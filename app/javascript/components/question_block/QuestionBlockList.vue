<template>
  <v-container
    class="rounded-2xl"
    v-show="isMyQuestionBlocksLengthNotZero || isThisEditPage"
  >
    <v-row v-show="isThisEditPage" justify="center">
      <v-btn
        id="add-question-block-btn"
        tile
        :color="questionBlockColor"
        class="ma-2 white--text"
        @click="openQuestionFormatDialog"
      >
        <v-icon left>
          mdi-plus
        </v-icon>
        クエスチョンブロックを追加する
      </v-btn>
    </v-row>
    <v-row justify="end">
      <div class="block-title">
        質問コーナー
      </div>
    </v-row>
    <div>
      <v-row v-if="isMyQuestionBlocksLengthNotZero">
        <v-col
          v-for="questionBlock in myQuestionBlocks"
          :key="questionBlock.id"
          cols="12"
          sm="4"
        >
          <v-card
            class="rounded-2xl p-5 note-box"
            outlined
            color="red lighten-4"
          >
            <v-row v-show="isThisEditPage" justify="end">
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
            <v-row>
              <v-spacer />
              <question-block-like-button
                :question-block-id="questionBlock.id"
              ></question-block-like-button>
            </v-row>
            <p class="text-2xl font-bold text-gray-600 px-3 py-3">
              {{ questionBlock.title }}
            </p>
            <template v-for="question_item in questionBlock.question_items">
              <div :key="question_item.id">
                <div class="rounded-lg">
                  <v-row>
                    <label for="question_item_content" class="mx-5 text-sm">
                      {{ question_item.content }}
                    </label>
                    <v-col cols="12" sm="12" class="mb-2">
                      <v-card class="p-2" outlined color="white">
                        {{ question_item.answer }}
                      </v-card>
                    </v-col>
                  </v-row>
                </div>
              </div>
            </template>
          </v-card>
        </v-col>
      </v-row>
      <v-container v-else class="no-block-display-container">
        <v-row justify="center">
          <div class="font-bold text-2xl opacity-50">
            社員のクエスチョンブロックがありません
          </div>
        </v-row>
      </v-container>
    </div>

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
import QuestionBlockLikeButton from "../likes/QuestionBlockLikeButton";

export default {
  components: {
    QuestionFormatDialog,
    EditQuestionFormatDialog,
    QuestionBlockLikeButton,
  },
  props: {
    isThisEditPage: {
      type: Boolean,
      required: false,
      default: false,
    },
    user: {
      type: Object,
      required: false,
    },
  },
  data() {
    return {
      isShownQuestionFormatDialog: false,
      isShownEditQuestionFormatDialog: false,
      editQuestionBlock: {},
      questionBlockColor: "red lighten-3", // question block colorz
    };
  },
  computed: {
    ...mapState("questionBlocks", ["questionBlocks"]),
    ...mapState("users", ["currentUser"]),

    myQuestionBlocks() {
      return (
        this.questionBlocks.filter(
          (questionBlock) =>
            questionBlock.profile_block.id == this.user.profile_block.id
        ) || {}
      );
    },

    isMyQuestionBlocksLengthNotZero() {
      return this.myQuestionBlocks.length !== 0 ? true : false;
    },
  },
  methods: {
    ...mapActions({
      deleteQuestionBlock: "questionBlocks/deleteQuestionBlock",
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

<style scoped>
/* .bg-color {
  background-color: #fce4ec;
} */

.block-title {
  color: #ef9a9a;
  padding: 10px;
  position: relative;
  font-size: 2rem;
  margin: 0.5rem;
}

.block-title:after {
  background: repeating-linear-gradient(
    -45deg,
    #f0b8bf,
    #f0b8bf 6px,
    #fcf0f1 0,
    #fcf0f1 10px
  );
  content: "";
  height: 10px;
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 1;
}

.note-box {
  background-image: radial-gradient(#ffffff 40%, transparent 20%),
    radial-gradient(#ffffff 20%, transparent 20%);
  background-size: 40px 40px;
  background-position: 0 0, 20px 20px;
}

.no-block-display-container {
  height: 300px;
}
</style>
