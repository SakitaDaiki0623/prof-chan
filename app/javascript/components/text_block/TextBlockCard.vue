<template>
  <div>
    <v-card class="rounded-2xl p-5 note-box" outlined color="teal accent-1">
      <v-row v-if="isThisEditPage" justify="end">
        <v-btn
          :id="'edit-text-block-button-' + textBlock.id"
          tile
          small
          color="teal lighten-4"
          @click="openEditTextFormatDialog(textBlock)"
        >
          <v-icon> mdi-pencil </v-icon>
        </v-btn>
        <v-btn
          :id="'delete-text-block-button-' + textBlock.id"
          tile
          small
          color="teal lighten-1"
          @click="hundleDeleteTextBlock(textBlock)"
        >
          <v-icon> mdi-delete </v-icon>
        </v-btn>
      </v-row>
      <v-row v-else>
        <v-spacer />
        <text-block-like-button
          :text-block-id="textBlock.id"
        ></text-block-like-button>
      </v-row>
      <p class="text-2xl font-bold text-gray-600 px-3 pt-3">
        {{ textBlock.title }}
      </p>
      <v-card class="p-3 rounded-lg" outlined color="white" min-height="200px">
        {{ textBlock.text }}
      </v-card>
    </v-card>
    <EditTextFormatDialog
      :is-shown-edit-text-format-dialog="isShownEditTextFormatDialog"
      :text-block-color="textBlockColor"
      :edit-text-block="editTextBlock"
      @close-edit-text-format-dialog="closeEditTextFormatDialog"
    />
  </div>
</template>

<script>
import TextBlockLikeButton from "../likes/TextBlockLikeButton";
import EditTextFormatDialog from "./EditTextFormatDialog";

import { mapActions } from "vuex";

export default {
  components: {
    TextBlockLikeButton,
    EditTextFormatDialog,
  },
  props: {
    textBlock: {
      type: Object,
      requred: true,
    },
    isThisEditPage: {
      type: Boolean,
      required: false,
      default: false,
    },
    textBlockColor: {
      type: String,
      requred: false,
      default: "teal lighten-3",
    },
  },
  data() {
    return {
      isShownEditTextFormatDialog: false,
      editTextBlock: {},
    };
  },
  methods: {
    ...mapActions({
      deleteTextBlock: "textBlocks/deleteTextBlock",
    }),
    openEditTextFormatDialog(textBlock) {
      this.editTextBlock = Object.assign({}, textBlock);
      this.isShownEditTextFormatDialog = true;
    },
    closeEditTextFormatDialog() {
      this.isShownEditTextFormatDialog = false;
    },
    hundleDeleteTextBlock(textBlock) {
      if (!confirm("削除してよろしいですか?")) return;
      this.deleteTextBlock(textBlock);
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "テキストブロックを削除したよ！",
        color: this.textBlockColor,
      });
    },
  },
};
</script>

<style scoped>
.note-box {
  position: relative;
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
