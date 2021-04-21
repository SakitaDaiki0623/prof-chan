<!-- app/javascript/components/QuestionBlockSelectDialog.vue -->
<template>
  <v-dialog
    :value="isShownQuestionBlockSelectDialog"
    max-width="800"
    persistent
    @input="$emit('input', $event.target.isShownQuestionBlockSelectDialog)"
  >
    <v-card color="red lighten-3">
      <v-row justify="end" class="mr-2 mt-2">
        <v-btn
          color="red lighten-3"
          @click="hundleCloseQuestionBlockSelectDialog"
        >
          ✖︎
        </v-btn>
      </v-row>
      <p
        class="font-weight-bold font-prof-default text-white text-4xl text-center mt-10"
      >
        フォーマットを選択してください
      </p>
      <div class="p-8 bg-question-prof-block bg-center">
        <v-row>
          <v-col cols="12" sm="6">
            <v-card>
              <v-img
                class="white--text align-end"
                height="200px"
                :src="require('../../images/question_block.png')"
              >
                <v-card-title class="font-prof-default">
                  クエスチョンフォーマット
                </v-card-title>
              </v-img>

              <v-card-text class="font-prof-default text-gray-600">
                <div>★使い方: 質問を作ってそれを自分で答えるよ！</div>
              </v-card-text>

              <v-card-actions>
                <v-btn
                  color="red lighten-3"
                  class="font-prof-default white--text"
                  @click="openQuestionFormatDialog"
                >
                  <v-icon left> mdi-pencil </v-icon>
                  このフォーマットを使う
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-col>
        </v-row>
      </div>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    isShownQuestionBlockSelectDialog: {
      type: Boolean,
      required: true,
    },
  },
  methods: {
    openQuestionFormatDialog() {
      this.$emit("open-question-format-dialog");
    },
    hundleCloseQuestionBlockSelectDialog() {
      this.$emit("close-question-block-select-dialog");
    },
  },
};
</script>
