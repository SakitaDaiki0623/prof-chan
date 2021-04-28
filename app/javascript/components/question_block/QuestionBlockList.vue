<template>
  <v-container>
    <v-row justify="center" v-show="isThisEditPage">
      <v-btn
        id="add-question-block-btn"
        tile
        :color="questionBlockColor"
        class="ma-2 white--text"
        @click="openQuestionFormatDialog"
      >
        <v-icon left> mdi-plus </v-icon>
        クエスチョンブロックを追加する
      </v-btn>
    </v-row>
    <v-row>
      <v-col
        v-for="questionBlock in myQuestionBlocks"
        :key="questionBlock.id"
        cols="12"
        sm="6"
      >
        <v-card class="bg-question-prof-block bg-cover shadow rounded-2xl p-5">
          <v-row justify="end" v-show="isThisEditPage">
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
          <p class="text-2xl font-bold text-gray-600 pt-3">
            {{ questionBlock.title }}
          </p>
          <template v-for="question_item in questionBlock.question_items">
            <div :key="question_item.id">
              <v-card class="p-5 rounded-lg" outlined>
                <v-row>
                  <v-col cols="12" sm="4">
                    {{ question_item.content }}
                  </v-col>
                  <v-col cols="12" sm="8" class="text-red-500">
                    {{ question_item.answer }}
                  </v-col>
                </v-row>
              </v-card>
            </div>
          </template>
        </v-card>
      </v-col>
    </v-row>
    <QuestionFormatDialog
      :is-shown-question-format-dialog="isShownQuestionFormatDialog"
      :question-block-color="questionBlockColor"
      @close-question-format-dialog="closeQuestionFormatDialog"
    />
    <EditQuestionFormatDialog
      :is-shown-edit-question-format-dialog="isShownEditQuestionFormatDialog"
      :edit-question-block="editQuestionBlock"
      :question-block-color="questionBlockColor"
      @close-question-block-format-dialog="closeEditQuestionFormatDialog"
      @close-question-block-edit-dialog="closeQuestionBlockEditDialog"
    />
  </v-container>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions } from "vuex";

import QuestionFormatDialog from "./QuestionFormatDialog";
import EditQuestionFormatDialog from "./EditQuestionFormatDialog";

export default {
  components: {
    QuestionFormatDialog,
    EditQuestionFormatDialog,
  },
  props: {
    isThisEditPage: {
      type: Boolean,
      required: false,
      default: false,
    },
  },
  data() {
    return {
      isShownQuestionFormatDialog: false,
      isShownEditQuestionFormatDialog: false,
      editQuestionBlock: {},
      questionBlockColor: "red lighten-3", // question block color
    };
  },
  computed: {
    ...mapState("questionBlocks", ["questionBlocks"]),
    ...mapState("users", ["currentUser"]),

    myQuestionBlocks() {
      return (
        this.questionBlocks.filter(
          (questionBlock) =>
            questionBlock.profile_block.id == this.currentUser.profile_block.id
        ) || {}
      );
    },
  },
  methods: {
    ...mapActions({
      fetchQuestionBlocks: "questionBlocks/fetchQuestionBlocks",
      deleteQuestionBlock: "questionBlocks/deleteQuestionBlock",
      fetchQuestionItems: "questionBlocks/fetchQuestionItems",
    }),
    openQuestionFormatDialog() {
      this.isShownQuestionFormatDialog = true;
    },
    closeQuestionFormatDialog() {
      this.isShownQuestionFormatDialog = false;
    },
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
