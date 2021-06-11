<template>
  <v-dialog
    :value="isShownTextFormatDialog"
    max-width="800"
    @click:outside="hundleCloseTextFormatDialog"
    @input="$emit('input', $event.target.isShownTextFormatDialog)"
  >
    <v-card :color="textBlockColor">
      <div>
        <v-row justify="end" class="mr-2 mt-2">
          <v-btn :color="textBlockColor" @click="hundleCloseTextFormatDialog">
            <v-icon> mdi-close-outline </v-icon>
          </v-btn>
        </v-row>
        <p class="font-weight-bold text-white text-4xl text-center mt-10 mb-10">
          テキストブロック作成
        </p>
      </div>
      <div id="text-block-form" class="pa-10 note-box">
        <v-btn
          id="input-text-title-button"
          type="submit"
          depressed
          elevation="4"
          small
          tile
          color="cyan lighten-2"
          class="white--text py-2"
          @click="inputTitleRandomly"
        >
          <v-icon left> mdi-plus </v-icon>テキストフォーマットをランダムに入力
        </v-btn>
        <ValidationObserver ref="observer" v-slot="{ invalid }">
          <form @submit.prevent="hundleCreateTextBlock(textBlock)">
            <div>
              <label class="form-label-text-block" for="text_block_title"
                >タイトル</label
              >
              <ValidationProvider
                v-slot="{ errors }"
                name="タイトル"
                rules="input_required|max:50"
              >
                <input
                  id="text_block_title"
                  v-model="textBlock.title"
                  class="input-form-text-block"
                  name="text_block[text_block_title]"
                  type="text"
                />
                <span class="red--text">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>
            <div class="mt-5">
              <label class="form-label-text-block" for="text_block_text"
                >テキスト</label
              >
              <ValidationProvider
                v-slot="{ errors }"
                name="テキスト"
                rules="input_required|max:200"
              >
                <textarea
                  id="text_block_text"
                  v-model="textBlock.text"
                  class="input-form-text-block"
                  name="text_block[text_block_text]"
                  rows="7"
                />
                <span class="red--text">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <div class="mt-3 font-weight-bold text-gray-600 text-sm">
              ※Slackへの投稿は1日に1回のみです。
            </div>
            <div class="text-center mt-3">
              <v-btn
                id="creation_button"
                type="submit"
                depressed
                elevation="4"
                x-large
                :disabled="invalid"
                :color="textBlockColor"
                class="white--text"
              >
                テキストブロックを作成！
              </v-btn>
            </div>
          </form>
        </ValidationObserver>
      </div>
    </v-card>
  </v-dialog>
</template>

<script>
// plugins
import axios from "axios";
import { mapActions, mapState } from "vuex";

// components ----------

export default {
  props: {
    isShownTextFormatDialog: {
      type: Boolean,
      required: true,
    },
    textBlockColor: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      textBlock: {
        title: "",
        text: "",
      },
      randomTextTitles: [
        {
          title: "子供の時の私",
          text:
            "幼稚園の頃は【】子供でした。小学校では【】が印象に残ってます。中学では部活は【】に入りました。部活は【】だったなー。高校は【】って感じでした。高校の部活は【】でした。あのころはすごく【】ました。ああー【】だったなー",
        },
        {
          title: "簡単な自己紹介",
          text:
            "私は【】年【】月【】日生まれの【】座だよ！性格はよく【】って言われます。1番の特技は【】で最近は【】にはまっています！私は芸能人でいうと【】と似ているかなと思う！",
        },
      ],
    };
  },
  computed: {
    ...mapState("users", ["currentUser"]),
  },
  methods: {
    ...mapActions({
      updateCurrentUserShareRight: "users/updateCurrentUserShareRight",
    }),
    hundleCreateTextBlock(textBlock) {
      this.createTextBlock(textBlock);
      if (
        this.currentUser.provider == "slack" &&
        this.currentUser.share_right == "not_shared_yet"
      ) {
        if (confirm("slackに通知しますか?")) {
          this.postToSlackAfterCreate(textBlock);
          this.updateCurrentUserShareRight(this.currentUser);
        }
      }
      this.hundleCloseTextFormatDialog();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "テキストブロックを作成したよ！",
        color: this.textBlockColor,
      });
    },
    createTextBlock(textBlock) {
      axios
        .post("/api/v1/text_blocks", textBlock)
        .then((res) => this.$emit("add-text-block", res.data));
    },
    async postToSlackAfterCreate(textBlock) {
      const res = await axios.post(
        "/api/v1/text_blocks/post_to_slack_after_create",
        textBlock
      );
    },
    hundleCloseTextFormatDialog() {
      this.$emit("close-text-format-dialog");
      this.clearTextBlock();
    },
    clearTextBlock() {
      this.textBlock.title = "";
      this.textBlock.text = "";
      requestAnimationFrame(() => {
        this.$refs.observer.reset();
      });
    },

    inputTitleRandomly() {
      const randomNum = Math.floor(
        Math.random() * this.randomTextTitles.length
      );
      this.textBlock.title = this.randomTextTitles[randomNum].title;
      this.textBlock.text = this.randomTextTitles[randomNum].text;
    },
  },
};
</script>

<style scoped>
.note-box {
  position: relative;
  background: #a7ffeb;
}

.note-box::after {
  content: "＊*"; /*花に見せかけるためのアスタリスク*/
  color: #fff; /* アスタリスクの色 */
  display: inline-block;
  font-size: 30px; /* アスタリスクの大きさ */
  font-weight: bold;
  position: absolute;
  top: 0px;
  left: 0px;
  transform: rotate(20deg);
  -moz-transform: rotate(20deg);
  -webkit-transform: rotate(20deg);
  -o-transform: rotate(20deg);
  text-shadow: 0px 0px 6px #eaa8bf, 0px 0px 4px #eaa8bf, 0 0 0.5px #eaa8bf; /* アスタリスク周りの影 */
}
</style>
