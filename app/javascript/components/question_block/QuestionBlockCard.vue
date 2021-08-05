<template>
  <div>
    <v-card class="rounded-2xl pa-5 note-box" outlined color="red lighten-4">
      <v-row v-if="isThisEditPage" justify="end">
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
        <EditQuestionFormatDialog
          :is-shown-edit-question-format-dialog="
            isShownEditQuestionFormatDialog
          "
          :edit-question-block="editQuestionBlock"
          :question-block-color="questionBlockColor"
          :question-items="questionItems"
          @close-question-block-format-dialog="closeEditQuestionFormatDialog"
          @close-question-block-edit-dialog="closeQuestionBlockEditDialog"
          @update-question-block="$listeners['update-question-block']"
          @add-question-item="$listeners['add-question-item']"
          @update-question-item="$listeners['update-question-item']"
          @retrieve-question-item="$listeners['retrieve-question-item']"
        />
      </v-row>
      <v-row v-else>
        <v-spacer />
        <question-block-like-button
          v-if="isThisNotTopPage"
          :question-block-id="questionBlock.id"
        />
      </v-row>
      <p class="profile-block-title">
        {{ questionBlock.title }}
      </p>
      <template v-for="question_item in questionBlock.question_items">
        <div :key="question_item.id">
          <div class="rounded-lg">
            <v-row>
              <label for="question_item_content" class="mx-5 text-xl">
                {{ question_item.content }}
              </label>
              <v-col cols="12" sm="12" class="mb-2">
                <v-card class="pa-2" outlined color="white">
                  {{ question_item.answer }}
                </v-card>
              </v-col>
            </v-row>
          </div>
        </div>
      </template>
    </v-card>
  </div>
</template>

<script>
import axios from "axios";
import EditQuestionFormatDialog from "./EditQuestionFormatDialog";
import QuestionBlockLikeButton from "../likes/QuestionBlockLikeButton";

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
    questionItems: {
      type: Array,
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
  computed: {
    isThisNotTopPage() {
      return this.$route.path == `/top` ? false : true;
    },
  },
  methods: {
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
    hundleDeleteQuestionBlock(questionBlock) {
      if (!confirm("削除してよろしいですか?")) return;
      this.deleteQuestionBlock(questionBlock);
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "クエスチョンブロックを削除したよ！",
        color: "red lighten-3",
      });
    },
    async deleteQuestionBlock(questionBlock) {
      await axios
        .delete(`/api/v1/question_blocks/${questionBlock.id}`, questionBlock)
        .then((response) => {
          this.$emit("retrieve-question-block", response.data);
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
