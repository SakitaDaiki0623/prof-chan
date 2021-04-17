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
        <p
          class="font-weight-bold font-prof-default text-white text-4xl text-center mt-10"
        >
          クエスチョンブロック
        </p>
        <div id="text-block-form" class="p-10 bg-question-prof-block bg-center">
          <ValidationObserver ref="observer" v-slot="{ invalid }">
            <form @submit.prevent="hundleCreateTextBlock(questionBlock)">
              <div>
                <label class="form-label" for="question_block_title"
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
                    class="input-form"
                    name="question_block[question_block_title]"
                    type="text"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>
              <div class="text-center mt-3">
                <v-btn
                  id="creation_button"
                  type="submit"
                  depressed
                  elevation="4"
                  x-large
                  :disabled="invalid"
                  color="blue-grey darken-2"
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
  </div>
</template>

<script>
// plugins
import axios from "axios";
import { mapActions } from "vuex";

// components ----------

export default {
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
        questionItem: {
          content: "",
          answer: "",
        },
      },
    };
  },
  methods: {
    ...mapActions("textBlocks", ["createTextBlock"]),

    hundleCreateTextBlock(textBlock) {
      if (textBlock.title == "" || textBlock.title == "") return;
      this.createTextBlock(textBlock);
      this.hundleCloseTextFormatDialog();
    },
    hundleCloseTextFormatDialog() {
      this.clearTextBlock();
      this.$emit("close-text-format-dialog");
    },
    clearTextBlock() {
      this.textBlock = {};
    },
  },
};
</script>


