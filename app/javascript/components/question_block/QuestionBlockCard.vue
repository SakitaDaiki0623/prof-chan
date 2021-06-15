<template>
  <div>
    <v-card
      class="rounded-2xl pa-5 note-box"
      outlined
      color="red lighten-4"
    >
      <v-row
        v-if="isThisEditPage"
        justify="end"
      >
        <v-btn
          :id="'edit-question-block-button-' + questionBlock.id"
          tile
          small
          color="red lighten-4"
          @click="openEditQuestionFormatDialog(questionBlock)"
        >
          <v-icon> mdi-pencil </v-icon>
        </v-btn>
        <v-btn
          :id="'delete-question-block-button-' + questionBlock.id"
          tile
          small
          color="red lighten-1"
          @click="hundleDeleteQuestionBlock(questionBlock)"
        >
          <v-icon> mdi-delete </v-icon>
        </v-btn>
      </v-row>
      <v-row v-else>
        <v-spacer />
        <question-block-like-button
          :question-block-id="questionBlock.id"
        />
      </v-row>
      <p class="text-2xl font-bold text-gray-600 px-3 py-3">
        {{ questionBlock.title }}
      </p>
      <template v-for="question_item in questionBlock.question_items">
        <div :key="question_item.id">
          <div class="rounded-lg">
            <v-row>
              <label
                for="question_item_content"
                class="mx-5"
              >
                {{ question_item.content }}
              </label>
              <v-col
                cols="12"
                sm="12"
                class="mb-2"
              >
                <v-card
                  class="pa-2"
                  outlined
                  color="white"
                >
                  {{ question_item.answer }}
                </v-card>
              </v-col>
            </v-row>
          </div>
        </div>
      </template>
    </v-card>
    <EditQuestionFormatDialog
      :is-shown-edit-question-format-dialog="isShownEditQuestionFormatDialog"
      :edit-question-block="editQuestionBlock"
      :question-block-color="questionBlockColor"
      @close-question-block-format-dialog="closeEditQuestionFormatDialog"
      @close-question-block-edit-dialog="closeQuestionBlockEditDialog"
    />
  </div>
</template>

<script>
import EditQuestionFormatDialog from "./EditQuestionFormatDialog";
import QuestionBlockLikeButton from "../likes/QuestionBlockLikeButton";

import { mapActions } from "vuex";

export default {
  components: {
    EditQuestionFormatDialog,
    QuestionBlockLikeButton,
  },
  props: {
    questionBlock: {
      type: Object,
      requred: true,
    },
    isThisEditPage: {
      type: Boolean,
      required: false,
      default: false,
    },
    questionBlockColor: {
      type: String,
      requred: false,
      default: "red lighten-3",
    },
  },
  data() {
    return {
      isShownEditQuestionFormatDialog: false,
      editQuestionBlock: {},
    };
  },
  methods: {
    ...mapActions({
      deleteQuestionBlock: "questionBlocks/deleteQuestionBlock",
    }),
    openEditQuestionFormatDialog(questionBlock) {
      this.editQuestionBlock = Object.assign({}, questionBlock);
      this.isShownEditQuestionFormatDialog = true;
    },
    closeEditQuestionFormatDialog() {
      this.isShownEditQuestionFormatDialog = false;
    },
    closeQuestionBlockEditDialog(editQuestionBlock) {
      this.editQuestionBlock = editQuestionBlock;
    },
    hundleDeleteQuestionBlock(QuestionBlock) {
      if (!confirm("削除してよろしいですか?")) return;
      this.deleteQuestionBlock(QuestionBlock);
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "クエスチョンブロックを削除したよ！",
        color: "red lighten-3",
      });
    },
  },
};
</script>

<style scoped>
.note-box {
  background-image: radial-gradient(#ffffff 40%, transparent 20%),
    radial-gradient(#ffffff 20%, transparent 20%);
  background-size: 40px 40px;
  background-position: 0 0, 20px 20px;
}
</style>
