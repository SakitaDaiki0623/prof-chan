<!-- app/javascript/components/QuestionFormatDialog.vue -->
<template>
  <div>
    <v-dialog
      :value="isShownQuestionFormatDialog"
      max-width="1000"
      persistent
      @input="$emit('input', $event.target.isShownQuestionFormatDialog)"
    >
      <v-card :color="questionBlockColor">
        <v-row justify="end" class="mr-2 mt-2">
          <v-btn
            :color="questionBlockColor"
            @click="hundleCloseQuestioniFormatDialog"
          >
            <v-icon> mdi-close-outline </v-icon>
          </v-btn>
        </v-row>
        <p class="font-weight-bold text-white text-4xl text-center mt-10">
          クエスチョンブロック
        </p>

        <div id="question-block-form" class="pa-10 note-box">
          <v-row>
            <v-col cols="12" sm="7">
              <v-btn
                id="add-question-item-button"
                type="submit"
                depressed
                elevation="4"
                small
                tile
                color="red lighten-2"
                class="white--text"
                :disabled="questionItemNum >= 3"
                @click="addQuestionItemNum"
              >
                <v-icon left> mdi-plus </v-icon>
                質問と答えを追加する
              </v-btn>
              <v-btn
                id="delete-question-item-button"
                type="submit"
                depressed
                elevation="4"
                small
                tile
                color="grey darken-3"
                class="white--text"
                :disabled="questionItemNum <= 1"
                @click="deleteQuestionItemNum"
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
                color="red lighten-2"
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
                hundleCreateQuestionBlock(
                  questionBlock,
                  questionItem1,
                  questionItem2,
                  questionItem3
                )
              "
            >
              <div>
                <label class="form-label-text-block" for="question_block_title"
                  >タイトル</label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  name="タイトル"
                  rules="input_required|max:50"
                >
                  <input
                    id="question_block_title"
                    v-model="questionBlock.title"
                    class="input-form-question-block"
                    name="question_block[question_block_title]"
                    type="text"
                  />
                  <span class="red--text">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>

              <!-- Item Form -->
              <QuestionBlockItem
                question-block-item-id="create-question-item-1"
                :question-item="questionItem1"
                :question-name-for-validation="questionNameForValidation1"
                :answer-name-for-validation="answerNameForValidation1"
              />
              <QuestionBlockItem
                v-if="questionItemNum >= 2"
                question-block-item-id="create-question-item-2"
                :question-item="questionItem2"
                :question-name-for-validation="questionNameForValidation2"
                :answer-name-for-validation="answerNameForValidation2"
              />
              <QuestionBlockItem
                v-if="questionItemNum >= 3"
                question-block-item-id="create-question-item-3"
                :question-item="questionItem3"
                :question-name-for-validation="questionNameForValidation3"
                :answer-name-for-validation="answerNameForValidation3"
              />

              <div class="text-center pa-10">
                <v-btn
                  id="creation_button"
                  type="submit"
                  depressed
                  elevation="4"
                  x-large
                  :disabled="invalid"
                  :color="questionBlockColor"
                  class="white--text"
                >
                  <v-icon left> mdi-plus </v-icon>
                  クエスチョンブロックを作成！
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
import QuestionBlockItem from "./QuestionBlockItem";

export default {
  components: {
    QuestionBlockItem,
  },
  props: {
    isShownQuestionFormatDialog: {
      type: Boolean,
      required: true,
    },
    questionBlockColor: {
      type: String,
      required: false,
    },
  },
  data() {
    return {
      questionBlock: {
        title: "",
      },
      questionItemNum: 1, // アイテム数
      questionItem1: {
        content: "",
        answer: "",
      },
      questionItem2: {
        content: "",
        answer: "",
      },
      questionItem3: {
        content: "",
        answer: "",
      },

      randomeTitles: [
        {
          title: "現在の交際",
          contents: [
            "付き合ってどのくらいですか？",
            "どちらからアプローチした？",
            "相手のことを何て呼んでる？",
            "何回目のデートで告白された？",
            "相手にもらって嬉しかった物は？",
          ],
        },
        {
          title: "鬼滅の刃",
          contents: [
            "好きな台詞は何ですか？",
            "好きな呼吸は何ですか？",
            "使ってみたい技は何ですか？",
            "1番好きなキャラは誰ですか？",
            "可愛いと思うキャラは誰ですか？",
            "カッコ良いと思うキャラは誰ですか？",
            "無限列車編は何回見ましたか？",
          ],
        },
        {
          title: "お金",
          contents: [
            "100万円あったら何に使う？",
            "月にいくら貯金しますか？",
            "所持品でいちばん高いものは？",
            "あなたにとってお金とは？",
            "週に何度自炊しますか？",
          ],
        },
        {
          title: "子供時代",
          contents: [
            "なりたかった職業は？",
            "50メートル走タイムは？",
            "中間テストの順位は？",
            "友達とは何をして遊んでいましたか？",
            "部活は何部でしたか？",
            "昔好きだった遊びは？",
            "昔習ってた習い事は？",
          ],
        },
        {
          title: "If...",
          contents: [
            "総理大臣になったら何を変えたい？",
            "嵐のメンバーになったら何をする？",
            "世界が明日滅びるとしたら明日までに何をする？",
            "本、テレビ、映画の世界で生きられるならどんな作品の世界に住みたい？",
            "100万円が手に入ったら何に使う？",
            "どこにでも行けるならどこを旅したい？",
            "無人島に一つだけ持ってくとしたら何ですか？",
          ],
        },
        {
          title: "下らない質問になんでも答えます！",
          contents: [
            "努力すれば夢は叶いますか？",
            "友達と親友の違いは何ですか？",
            "パンの耳の1番いい利用方法は？",
            "目からビームの出し方は？",
            "今の心を俳句にすると何ですか？",
            "小学生に絡まれた時の対処法は？",
          ],
        },
        {
          title: "あなたが思う誰誰",
          contens: [
            "あなたが思う優しい人は？",
            "あなたが思う腹黒な人は",
            "仕事ができる人",
            "頭いい人",
            "かっこいい人",
          ],
        },
      ],

      // Validator
      questionNameForValidation1: "1番目の質問",
      answerNameForValidation1: "1番目の答え",
      questionNameForValidation2: "2番目の質問",
      answerNameForValidation2: "2番目の答え",
      questionNameForValidation3: "3番目の質問",
      answerNameForValidation3: "3番目の答え",
    };
  },
  computed: {
    ...mapState("users", ["currentUser"]),
  },
  methods: {
    ...mapActions({
      createQuestionBlock: "questionBlocks/createQuestionBlock",
    }),
    addQuestionItemNum() {
      this.questionItemNum++;
    },
    deleteQuestionItemNum() {
      this.questionItemNum--;
      if (this.questionItemNum == 2) {
        this.questionItem3.content = "";
        this.questionItem3.answer = "";
      } else if (this.questionItemNum == 1) {
        this.questionItem2.content = "";
        this.questionItem2.answer = "";
      }
    },
    hundleCreateQuestionBlock(
      questionBlock,
      questionItem1,
      questionItem2,
      questionItem3
    ) {
      const params = {
        question_title: questionBlock.title,
        question_item_content1: questionItem1.content,
        question_item_answer1: questionItem1.answer,
        question_item_content2: questionItem2.content,
        question_item_answer2: questionItem2.answer,
        question_item_content3: questionItem3.content,
        question_item_answer3: questionItem3.answer,
      };
      this.createQuestionBlock(params);
      this.hundleCloseQuestioniFormatDialog();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "クエスチョンブロックを作成したよ！",
        color: this.questionBlockColor,
      });

      if (this.currentUser.provider == "slack") {
        if (confirm("slackに通知しますか?")) {
          this.postToSlackAfterCreate(params);
        }
      }
    },
    async postToSlackAfterCreate(params) {
      const res = await axios.post(
        "/api/v1/question_blocks/post_to_slack_after_create",
        params
      );
    },
    hundleCloseQuestioniFormatDialog() {
      this.$emit("close-question-format-dialog");
      this.clearQuestionBlock();
    },

    clearQuestionBlock() {
      this.questionItemNum = 1; // アイテム数のリセット
      this.questionBlock.title = "";
      this.questionItem1.content = "";
      this.questionItem1.answer = "";
      this.questionItem2.content = "";
      this.questionItem2.answer = "";
      this.questionItem3.content = "";
      this.questionItem3.answer = "";
      requestAnimationFrame(() => {
        this.$refs.observer.reset();
      });
    },
    inputTitleRandomly() {
      const randomNum = Math.floor(Math.random() * this.randomeTitles.length);
      const selectedRandomTitle = JSON.parse(
        JSON.stringify(this.randomeTitles[randomNum])
      );

      this.questionBlock.title = selectedRandomTitle.title;

      if (this.questionItemNum == 1) {
        const randomItemContentIndexForItem1 = Math.floor(
          Math.random() * selectedRandomTitle.contents.length
        );
        this.questionItem1.content = selectedRandomTitle.contents.splice(
          randomItemContentIndexForItem1,
          1
        )[0];
      } else if (this.questionItemNum == 2) {
        const randomItemContentIndexForItem1 = Math.floor(
          Math.random() * selectedRandomTitle.contents.length
        );
        this.questionItem1.content = selectedRandomTitle.contents.splice(
          randomItemContentIndexForItem1,
          1
        )[0];
        const randomItemContentIndexForItem2 = Math.floor(
          Math.random() * selectedRandomTitle.contents.length
        );
        this.questionItem2.content = selectedRandomTitle.contents.splice(
          randomItemContentIndexForItem2,
          1
        )[0];
      } else if (this.questionItemNum == 3) {
        const randomItemContentIndexForItem1 = Math.floor(
          Math.random() * selectedRandomTitle.contents.length
        );
        this.questionItem1.content = selectedRandomTitle.contents.splice(
          randomItemContentIndexForItem1,
          1
        )[0];
        const randomItemContentIndexForItem2 = Math.floor(
          Math.random() * selectedRandomTitle.contents.length
        );
        this.questionItem2.content = selectedRandomTitle.contents.splice(
          randomItemContentIndexForItem2,
          1
        )[0];
        const randomItemContentIndexForItem3 = Math.floor(
          Math.random() * selectedRandomTitle.contents.length
        );
        this.questionItem3.content = selectedRandomTitle.contents.splice(
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
  background-color: #ffcdd2;
  background-image: radial-gradient(#ffffff 40%, transparent 20%),
    radial-gradient(#ffffff 20%, transparent 20%);
  background-size: 40px 40px;
  background-position: 0 0, 20px 20px;
}
</style>
