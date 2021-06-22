<template>
  <v-dialog
    :value="isShownTextFormatSelectDialog"
    max-width="800"
    @click:outside="hundleCloseTextFormatSelectDialog"
    set="$emit('input', $event.target.isShownTextFormatSelectDialog)"
    transition="slide-x-transition"
  >
    <v-card :color="textBlockColor">
      <div>
        <v-row justify="end" class="mr-2 mt-2">
          <v-btn
            :color="textBlockColor"
            @click="hundleCloseTextFormatSelectDialog"
          >
            <v-icon> mdi-close-outline </v-icon>
          </v-btn>
        </v-row>
        <p class="font-weight-bold text-white text-4xl text-center mt-10 mb-10">
          テキストフォーマット選択
        </p>
      </div>
      <div
        id="text-block-form"
        class="pa-5 md:pa-10 note-box-no-mark text-xl md:text-2xl"
      >
        <v-row>
          <v-col
            v-for="titleAndText in titleAndTexts"
            :key="titleAndText.id"
            cols="12"
            sm="12"
          >
            <v-card
              class="note-box pa-5 md:pa-10 cursor-pointer"
              :color="textBlockColor"
              @click="hundleSetTitleAndText(titleAndText)"
            >
              <div class="text-2xl font-bold pa-5">
                {{ titleAndText.title }}
              </div>

              <v-card
                class="pa-3 rounded-lg"
                outlined
                color="white"
                min-height="200px"
              >
                {{ titleAndText.text }}
              </v-card>
            </v-card>
          </v-col>
        </v-row>
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
    isShownTextFormatSelectDialog: {
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
      titleAndTexts: [
        {
          id: 1,
          title: "子供の時の私",
          text:
            "幼稚園の頃は【】な子供でした。小学校では【】が印象に残ってます。中学では部活は【】に入りました。部活は【】だったなー。高校は【】って感じでした。高校の部活は【】でした。あのころはすごく【】ました。ああー【】だったなー",
        },
        {
          id: 2,
          title: "簡単な自己紹介",
          text:
            "私は【】年【】月【】日生まれの【】座だよ！性格はよく【】って言われます。1番の特技は【】で最近は【】にはまっています！私は芸能人でいうと【】に似ているかなと思う！",
        },
        {
          id: 3,
          title: "コナン風自己紹介",
          text:
            "オレは高校生【】、【】。幼なじみで同級生の【】と【】に遊びに行って、【】な現場を目撃した。【】を見るのに夢中になっていたオレは、【】に気付かなかった。【】を飲まされ、目が覚めたら【】！！",
        },
      ],
    };
  },
  methods: {
    hundleSetTitleAndText(titleAndText) {
      this.$emit("set-title-and-text", titleAndText);
      this.hundleCloseTextFormatSelectDialog();
    },
    hundleCloseTextFormatSelectDialog() {
      this.$emit("close-text-format-select-dialog");
    },
  },
};
</script>

<style scoped>
.note-box-no-mark {
  background: #a7ffeb;
}
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
