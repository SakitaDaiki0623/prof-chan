<template>
  <v-container>
    <v-row justify="center" v-show="isThisEditPage">
      <v-btn
        id="add-text-block-btn"
        tile
        :color="textBlockColor"
        class="ma-2 white--text"
        @click="openTextFormatDialog"
      >
        <v-icon left> mdi-plus </v-icon>
        テキストブロックを追加する
      </v-btn>
    </v-row>
    <v-row>
      <v-col
        v-for="textBlock in myTextBlocks"
        :key="textBlock.id"
        cols="12"
        sm="6"
      >
        <v-card class="bg-text-prof-block bg-cover shadow rounded-2xl p-5">
          <v-row justify="end" v-show="isThisEditPage">
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
          <p class="text-2xl font-bold text-gray-600 pt-3">
            {{ textBlock.title }}
          </p>
          <v-card class="p-5 rounded-lg" outlined>
            {{ textBlock.text }}
          </v-card>
        </v-card>
      </v-col>
    </v-row>
    <TextFormatDialog
      :is-shown-text-format-dialog="isShownTextFormatDialog"
      :text-block-color="textBlockColor"
      @close-text-format-dialog="closeTextFormatDialog"
    />
    <EditTextFormatDialog
      :is-shown-edit-text-format-dialog="isShownEditTextFormatDialog"
      :text-block-color="textBlockColor"
      :edit-text-block="editTextBlock"
      @close-edit-text-format-dialog="closeEditTextFormatDialog"
    />
  </v-container>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions, Store } from "vuex";

import TextFormatDialog from "./TextFormatDialog";
import EditTextFormatDialog from "./EditTextFormatDialog";

export default {
  components: {
    TextFormatDialog,
    EditTextFormatDialog,
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
      // Text Block
      isShownTextFormatDialog: false,
      isShownEditTextFormatDialog: false,
      editTextBlock: {},
      textBlockColor: "teal lighten-3", // text block color
    };
  },
  computed: {
    ...mapState("textBlocks", ["textBlocks"]),
    ...mapState("users", ["currentUser"]),
    myTextBlocks() {
      return (
        this.textBlocks.filter(
          (textBlock) =>
            textBlock.profile_block.id == this.currentUser.profile_block.id
        ) || {}
      );
    },
  },
  methods: {
    ...mapActions({
      fetchTextBlocks: "textBlocks/fetchTextBlocks",
      deleteTextBlock: "textBlocks/deleteTextBlock",
    }),
    openEditTextFormatDialog(textBlock) {
      this.$emit("open-edit-text-format-dialog", textBlock);
    },
    openTextFormatDialog() {
      this.isShownTextFormatDialog = true;
    },
    closeTextFormatDialog() {
      this.isShownTextFormatDialog = false;
    },
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
