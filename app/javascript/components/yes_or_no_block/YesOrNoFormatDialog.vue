<!-- app/javascript/components/yes_or_no_block/YesOrNoFormatDialog.vue -->
<template>
  <div>
    <v-dialog
      :value="isShownYesOrNoFormatDialog"
      max-width="800"
      persistent
      @input="$emit('input', $event.target.isShownYesOrNoFormatDialog)"
    >
      <v-card :color="yesOrNoBlockColor">
        <v-row justify="end" class="mr-2 mt-2">
          <v-btn
            :color="yesOrNoBlockColor"
            @click="hundleCloseYesOrNoFormatDialog"
          >
            <v-icon> mdi-close-outline </v-icon>
          </v-btn>
        </v-row>
        <p class="font-weight-bold text-white text-4xl text-center mt-10">
          Yes or No ブロック
        </p>

        <div
          id="yes-or-no-block-form"
          class="p-10 note-box"
          color="orange lighten-4"
        >
          <v-row>
            <v-col cols="12" sm="7">
              <v-btn
                id="add-yes-or-no-item-button"
                type="submit"
                depressed
                elevation="4"
                small
                tile
                color="orange lighten-2"
                class="white--text"
                :disabled="yesOrNoItemNum >= 3"
                @click="addYesOrNoItemNum"
              >
                <v-icon left> mdi-plus </v-icon>
                質問と答えを追加する
              </v-btn>
              <v-btn
                id="delete-yes-or-no-item-button"
                type="submit"
                depressed
                elevation="4"
                small
                tile
                color="grey darken-3"
                class="white--text"
                :disabled="yesOrNoItemNum <= 1"
                @click="deleteYesOrNoItemNum"
              >
                <v-icon left> mdi-minus </v-icon>
                質問と答えを減らす
              </v-btn>
            </v-col>
            <v-spacer />
            <v-col cols="12" sm="4">
              <v-btn
                id="input-yes-or-no-title-button"
                type="submit"
                depressed
                elevation="4"
                small
                tile
                color="orange lighten-2"
                class="white--text py-2"
                @click="inputTitleRandomly"
              >
                <v-icon left> mdi-plus </v-icon>タイトルをランダムに入力
              </v-btn>
            </v-col>
          </v-row>

          <ValidationObserver ref="observer" v-slot="{ invalid }">
            <form
              @submit.prevent="
                hundleCreateYesOrNoBlock(
                  yesOrNoBlock,
                  yesOrNoItem1,
                  yesOrNoItem2,
                  yesOrNoItem3
                )
              "
            >
              <div>
                <label
                  class="form-label-text-block"
                  for="yes_or_no_block_title"
                  >タイトル</label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  name="タイトル"
                  rules="input_required|max:50"
                >
                  <input
                    id="yes_or_no_block_title"
                    v-model="yesOrNoBlock.title"
                    class="input-form-yes-or-no-block"
                    name="yes_or_no_block[yes_or_no_block_title]"
                    type="text"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>

              <!-- Item Form -->
              <YesOrNoBlockItem
                yes-or-no-block-item-id="create-yes-or-no-item-1"
                :yes-or-no-item="yesOrNoItem1"
                :yes-or-no-name-for-validation="yesOrNoNameForValidation1"
                :answer-name-for-validation="answerNameForValidation1"
              />
              <YesOrNoBlockItem
                v-if="yesOrNoItemNum >= 2"
                yes-or-no-block-item-id="create-yes-or-no-item-2"
                :yes-or-no-item="yesOrNoItem2"
                :yes-or-no-name-for-validation="yesOrNoNameForValidation2"
                :answer-name-for-validation="answerNameForValidation2"
              />
              <YesOrNoBlockItem
                v-if="yesOrNoItemNum >= 3"
                yes-or-no-block-item-id="create-yes-or-no-item-3"
                :yes-or-no-item="yesOrNoItem3"
                :yes-or-no-name-for-validation="yesOrNoNameForValidation3"
                :answer-name-for-validation="answerNameForValidation3"
              />

              <div class="text-center p-10">
                <v-btn
                  id="creation_button"
                  type="submit"
                  depressed
                  elevation="4"
                  x-large
                  :disabled="invalid"
                  :color="yesOrNoBlockColor"
                  class="white--text"
                >
                  <v-icon left> mdi-plus </v-icon>
                  Yes or No ブロックを作成！
                </v-btn>
              </div>
            </form>
          </ValidationObserver>
        </div>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
// plugins
import axios from "axios";
import { mapActions, mapState } from "vuex";

// components ----------
import YesOrNoBlockItem from "./YesOrNoBlockItem";

export default {
  components: {
    YesOrNoBlockItem,
  },
  props: {
    isShownYesOrNoFormatDialog: {
      type: Boolean,
      required: true,
    },
    yesOrNoBlockColor: {
      type: String,
      required: false,
    },
  },
  data() {
    return {
      yesOrNoBlock: {
        title: "",
      },
      yesOrNoItemNum: 1, // アイテム数
      yesOrNoItem1: {
        content: "",
        answer: "",
      },
      yesOrNoItem2: {
        content: "",
        answer: "",
      },
      yesOrNoItem3: {
        content: "",
        answer: "",
      },

      randomeTitles: [
        {
          title: "結婚歴",
          contents: [
            "既婚願望はありますか？",
            "結婚したことはありますか？",
            "いつ結婚しましたか？",
            "いつ結婚したいですか？",
          ],
        },
        // {
        //   title: "私の働き方",
        //   contents: ["仕事は1人で黙々やるのが好き？", ""],
        // },
        // {
        //   title: "あなたが思う誰誰(イニシャルでもいいよ！)",
        //   contens: [
        //     "あなたが思う優しい人は？",
        //     "あなたが思う腹黒な人は",
        //     "仕事ができる人",
        //     "頭いい人",
        //     "かっこいい人",
        //   ],
        // },
        // { title: "コミュニケーション", contents: ["自分から話を始める？", ""] },
        // {
        //   title: "あなたの怒りポイント",
        //   contents: ["何されたら起こりますか？", ""],
        // },
        // {
        //   title: "遊び",
        //   contents: ["インドア派ですか？", "アウトドアが好きですか？"],
        // },
        // {
        //   title: "食べ物",
        //   contents: [
        //     "和食が好きですか？",
        //     "洋食が好きですか？",
        //     "iPhine派ですか？",
        //     "Android派ですか？",
        //   ],
        // },
        // {
        //   title: "住む場所",
        //   contents: ["将来は田舎に住みますか？", "将来は都会に住みますか？"],
        // },
      ],

      // Validator
      yesOrNoNameForValidation1: "1番目の質問",
      answerNameForValidation1: "1番目の答え",
      yesOrNoNameForValidation2: "2番目の質問",
      answerNameForValidation2: "2番目の答え",
      yesOrNoNameForValidation3: "3番目の質問",
      answerNameForValidation3: "3番目の答え",
    };
  },
  computed: {
    ...mapState("users", ["currentUser"]),
  },
  methods: {
    ...mapActions({
      createYesOrNoBlock: "yesOrNoBlocks/createYesOrNoBlock",
    }),
    addYesOrNoItemNum() {
      this.yesOrNoItemNum++;
    },
    deleteYesOrNoItemNum() {
      this.yesOrNoItemNum--;
      if (this.yesOrNoItemNum == 2) {
        this.yesOrNoItem3.content = "";
        this.yesOrNoItem3.answer = "";
      } else if (this.yesOrNoItemNum == 1) {
        this.yesOrNoItem2.content = "";
        this.yesOrNoItem2.answer = "";
      }
    },
    hundleCreateYesOrNoBlock(
      yesOrNoBlock,
      yesOrNoItem1,
      yesOrNoItem2,
      yesOrNoItem3
    ) {
      const params = {
        yes_or_no_title: yesOrNoBlock.title,
        yes_or_no_item_content1: yesOrNoItem1.content,
        yes_or_no_item_answer1: yesOrNoItem1.answer,
        yes_or_no_item_content2: yesOrNoItem2.content,
        yes_or_no_item_answer2: yesOrNoItem2.answer,
        yes_or_no_item_content3: yesOrNoItem3.content,
        yes_or_no_item_answer3: yesOrNoItem3.answer,
      };
      this.createYesOrNoBlock(params);
      this.hundleCloseYesOrNoFormatDialog();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "Yes or No ブロックを作成したよ！",
        color: this.yesOrNoBlockColor,
      });
      if (this.currentUser.provider == "slack") {
        if (confirm("slackに通知しますか?")) {
          this.postToSlackAfterCreate(params);
        }
      }
    },
    async postToSlackAfterCreate(params) {
      const res = await axios.post(
        "/api/v1/yes_or_no_blocks/post_to_slack_after_create",
        params
      );
    },
    hundleCloseYesOrNoFormatDialog() {
      this.$emit("close-yes-or-no-format-dialog");
      this.clearYesOrNoBlock();
    },

    clearYesOrNoBlock() {
      this.yesOrNoItemNum = 1; // アイテム数のリセット
      this.yesOrNoBlock.title = "";
      this.yesOrNoItem1.content = "";
      this.yesOrNoItem1.answer = "";
      this.yesOrNoItem2.content = "";
      this.yesOrNoItem2.answer = "";
      this.yesOrNoItem3.content = "";
      this.yesOrNoItem3.answer = "";
      requestAnimationFrame(() => {
        this.$refs.observer.reset();
      });
    },
    inputTitleRandomly() {
      const randomNum = Math.floor(Math.random() * this.randomeTitles.length);
      const selectedRandomTitle = JSON.parse(
        JSON.stringify(this.randomeTitles[randomNum])
      );

      this.yesOrNoBlock.title = selectedRandomTitle.title;

      if (this.yesOrNoItemNum == 1) {
        const randomItemContentIndexForItem1 = Math.floor(
          Math.random() * selectedRandomTitle.contents.length
        );
        this.yesOrNoItem1.content = selectedRandomTitle.contents.splice(
          randomItemContentIndexForItem1,
          1
        )[0];
      } else if (this.yesOrNoItemNum == 2) {
        const randomItemContentIndexForItem1 = Math.floor(
          Math.random() * selectedRandomTitle.contents.length
        );
        this.yesOrNoItem1.content = selectedRandomTitle.contents.splice(
          randomItemContentIndexForItem1,
          1
        )[0];
        const randomItemContentIndexForItem2 = Math.floor(
          Math.random() * selectedRandomTitle.contents.length
        );
        this.yesOrNoItem2.content = selectedRandomTitle.contents.splice(
          randomItemContentIndexForItem2,
          1
        )[0];
      } else if (this.yesOrNoItemNum == 3) {
        const randomItemContentIndexForItem1 = Math.floor(
          Math.random() * selectedRandomTitle.contents.length
        );
        this.yesOrNoItem1.content = selectedRandomTitle.contents.splice(
          randomItemContentIndexForItem1,
          1
        )[0];
        const randomItemContentIndexForItem2 = Math.floor(
          Math.random() * selectedRandomTitle.contents.length
        );
        this.yesOrNoItem2.content = selectedRandomTitle.contents.splice(
          randomItemContentIndexForItem2,
          1
        )[0];
        const randomItemContentIndexForItem3 = Math.floor(
          Math.random() * selectedRandomTitle.contents.length
        );
        this.yesOrNoItem3.content = selectedRandomTitle.contents.splice(
          randomItemContentIndexForItem3,
          1
        )[0];
      }
    },
  },
};
</script>

<style scoped>
.note-box {
  position: relative;
  background-color: #ffe0b2;
}
.note-box::before {
  content: "";
  position: absolute;
  border-right: dashed 5px rgb(155, 155, 155); /*ドットの大きさ、高さ*/
  height: 90%;
  top: 0.5em;
  left: 0.5em;
}

.note-box::after {
  content: "";
  position: absolute;
  border-right: dashed 5px rgb(155, 155, 155); /*ドットの大きさ、高さ*/
  height: 50%;
  top: 3em;
  right: 0.5em;
}
</style>
