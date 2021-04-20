<!-- app/javascript/components/QuestionFormatDialog.vue -->
<template>
  <div>
    <v-dialog
      :value="isShownQuestionFormatDialog"
      max-width="800"
      persistent
      @input="$emit('input', $event.target.isShownQuestionFormatDialog)"
    >
      <v-card color="red lighten-3">
        <v-row justify="end" class="mr-2 mt-2">
          <v-btn
            color="red lighten-3"
            @click="hundleCloseQuestioniFormatDialog"
          >
            ✖︎
          </v-btn>
        </v-row>
        <p
          class="font-weight-bold font-prof-default text-white text-4xl text-center mt-10"
        >
          クエスチョンブロック
        </p>

        <div
          id="question-block-form"
          class="p-10 bg-question-prof-block bg-fixed"
        >
          <div class="pb-2">
            <v-btn
              id="add_button"
              type="submit"
              depressed
              elevation="4"
              small
              tile
              color="red lighten-2"
              class="white--text font-prof-default"
              :disabled="questionItemNum >= 3"
              @click="addQuestionItemNum"
            >
              <v-icon left> mdi-plus </v-icon>
              質問と答えを追加する
            </v-btn>
            <v-btn
              id="delete_button"
              type="submit"
              depressed
              elevation="4"
              small
              tile
              color="grey darken-3"
              class="white--text font-prof-default"
              :disabled="questionItemNum <= 1"
              @click="deleteQuestionItemNum"
            >
              <v-icon left> mdi-minus </v-icon>
              質問と答えを追加する
            </v-btn>
          </div>
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
                <label
                  class="form-label-question-block"
                  for="question_block_title"
                  >タイトル</label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  name="タイトル"
                  rules="input_required|max:30"
                >
                  <input
                    id="question_block_title"
                    v-model="questionBlock.title"
                    class="input-form-question-block"
                    name="question_block[question_block_title]"
                    type="text"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>

              <!-- Item Form -->
              <QuestionBlockItem
                :questionItem="questionItem1"
                :questionNameForValidation="questionNameForValidation1"
                :answerNameForValidation="answerNameForValidation1"
              />
              <QuestionBlockItem
                :questionItem="questionItem2"
                v-if="questionItemNum >= 2"
                :questionNameForValidation="questionNameForValidation2"
                :answerNameForValidation="answerNameForValidation2"
              />
              <QuestionBlockItem
                :questionItem="questionItem3"
                v-if="questionItemNum >= 3"
                :questionNameForValidation="questionNameForValidation3"
                :answerNameForValidation="answerNameForValidation3"
              />

              <div class="text-center p-10">
                <v-btn
                  id="creation_button"
                  type="submit"
                  depressed
                  elevation="4"
                  x-large
                  :disabled="invalid"
                  color="red lighten-3"
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
import QuestionBlockItem from "./items/QuestionBlockItem";

export default {
  components: {
    QuestionBlockItem,
  },
  props: {
    isShownQuestionFormatDialog: {
      type: Boolean,
      required: true,
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
    ...mapState({
      currentUser: "users/currentUser",
    }),
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
        this.questionItem3 = {};
      } else if (this.questionItemNum == 1) {
        this.questionItem2 = {};
      }
    },
    hundleCreateQuestionBlock(
      questionBlock,
      questionItem1,
      questionItem2,
      questionItem3
    ) {
      this.createQuestionBlock({
        questionBlock: questionBlock,
        questionItem1: questionItem1,
        questionItem2: questionItem2,
        questionItem3: questionItem3,
      });
      this.hundleCloseQuestioniFormatDialog();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "クエスチョンブロックを作成したよ！",
        color: "red lighten-3",
      });
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
  },
};
</script>
