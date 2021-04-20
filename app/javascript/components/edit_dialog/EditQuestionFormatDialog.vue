<!-- app/javascript/components/TextFormatDialog.vue -->
<template>
  <div>
    <v-dialog
      :value="isShownEditQuestionFormatDialog"
      max-width="800"
      persistent
      @input="$emit('input', $event.target.isShownEditQuestionFormatDialog)"
    >
      <v-card color="red lighten-3">
        <v-row justify="end" class="mr-2 mt-2">
          <v-btn
            color="red lighten-3"
            @click="hundleCancelQuestioniFormatUpdate"
          >
            ✖︎
          </v-btn>
        </v-row>
        <p
          class="font-weight-bold font-prof-default text-white text-4xl text-center mt-10 mb-10"
        >
          クエスチョンブロックを編集
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
            <form @submit.prevent="hundleEditQuestionBlock(editQuestionBlock)">
              <div>
                <label class="form-label-text-block" for="text_block_title"
                  >タイトル</label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  name="タイトル"
                  rules="input_required|max:30"
                >
                  <input
                    id="text_block_title"
                    :value="editQuestionBlock.title"
                    @input="editQuestionBlock.title = $event.target.value"
                    class="input-form-text-block"
                    name="text_block[text_block_title]"
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
                :questionNameForValidation="questionNameForValidation2"
                :answerNameForValidation="answerNameForValidation2"
                v-if="questionItemLength >= 2"
              />
              <QuestionBlockItem
                :questionItem="questionItem3"
                :questionNameForValidation="questionNameForValidation3"
                :answerNameForValidation="answerNameForValidation3"
                v-if="questionItemLength >= 3"
              />

              <div class="text-center mt-3">
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
                  クエスチョンブロックを更新！
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
import { mapActions } from "vuex";

// components ----------
import QuestionBlockItem from "../items/QuestionBlockItem";

export default {
  components: {
    QuestionBlockItem,
  },
  props: {
    isShownEditQuestionFormatDialog: {
      type: Boolean,
      required: true,
    },
    editQuestionBlock: {
      type: Object,
      required: true,
    },
    textBlockColorForFlashMessage: {
      type: String,
      required: false,
    },
  },
  data() {
    return {
      questionItemNum: 3,
      questionNameForValidation1: "1番目の質問",
      answerNameForValidation1: "1番目の答え",
      questionNameForValidation2: "2番目の質問",
      answerNameForValidation2: "2番目の答え",
      questionNameForValidation3: "3番目の質問",
      answerNameForValidation3: "3番目の答え",
    };
  },
  computed: {
    questionItemLength() {
      return this.editQuestionBlock.question_items.length;
    },
    questionItem1() {
      return (this.editQuestionBlock.question_items[0] = Object.assign(
        {},
        this.editQuestionBlock.question_items[0]
      ));
    },
    questionItem2() {
      if (this.editQuestionBlock.question_items[1] == undefined) return;
      return (this.editQuestionBlock.question_items[1] = Object.assign(
        {},
        this.editQuestionBlock.question_items[1]
      ));
    },
    questionItem3() {
      if (this.editQuestionBlock.question_items[2] == undefined) return;
      return (this.editQuestionBlock.question_items[2] = Object.assign(
        {},
        this.editQuestionBlock.question_items[2]
      ));
    },
  },
  methods: {
    ...mapActions({
      patchQuestionBlockWithOneItems:
        "questionBlocks/patchQuestionBlockWithOneItems",
      patchQuestionBlockWithTwoItems:
        "questionBlocks/patchQuestionBlockWithTwoItems",
      patchQuestionBlockWithThreeItems:
        "questionBlocks/patchQuestionBlockWithThreeItems",
    }),
    hundleEditQuestionBlock(editQuestionBlock) {
      if (
        this.editQuestionBlock.question_items[1] == undefined ||
        this.editQuestionBlock.question_items[2] == undefined
      ) {
        this.patchQuestionBlockWithOneItems({
          questionBlock: editQuestionBlock,
          questionItem1: this.editQuestionBlock.question_items[0],
        });
      } else if (this.editQuestionBlock.question_items[2] == undefined) {
        this.patchQuestionBlockWithTwoItems({
          questionBlock: editQuestionBlock,
          questionItem1: this.editQuestionBlock.question_items[0],
          questionItem2: this.editQuestionBlock.question_items[1],
        });
      } else {
        this.patchQuestionBlockWithThreeItems({
          questionBlock: editQuestionBlock,
          questionItem1: this.editQuestionBlock.question_items[0],
          questionItem2: this.editQuestionBlock.question_items[1],
          questionItem3: this.editQuestionBlock.question_items[2],
        });
      }
      this.hundleCloseEditQuestionFormatDialog();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "テキストブロックを更新したよ！",
        color: this.textBlockColorForFlashMessage,
      });
    },

    addQuestionItemNum() {
      this.questionItemNum++;
    },
    deleteQuestionItemNum() {
      this.questionItemNum--;
    },

    hundleCloseEditQuestionFormatDialog() {
      this.$emit("close-question-block-format-dialog");
    },

    hundleCancelQuestioniFormatUpdate() {
      console.log("hundleCancelQuestioniFormatUpdate");
      this.editQuestionBlock = this.editQuestionBlock;
      this.hundleCloseEditQuestionFormatDialog();
    },
  },
};
</script>
