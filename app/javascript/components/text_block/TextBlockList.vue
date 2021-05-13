<template>
  <v-container
    class="rounded-2xl bg-color"
    v-show="isMyTextBlocksLengthNotZero || isThisEditPage"
  >
    <v-row v-show="isThisEditPage" justify="center">
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
      <div class="block-title">テキストコーナー</div>
    </v-row>
    <div>
      <transition-group v-if="isMyTextBlocksLengthNotZero" tag="v-row" appear>
        <v-col
          v-for="textBlock in myTextBlocks"
          :key="textBlock.id"
          cols="12"
          sm="6"
        >
          <v-card
            class="rounded-2xl p-5 note-box"
            outlined
            color="teal accent-1"
          >
            <v-row v-show="isThisEditPage" justify="end">
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
            <p class="text-2xl font-bold text-gray-600 px-3 pt-3">
              {{ textBlock.title }}
            </p>
            <v-card
              class="p-3 rounded-lg"
              outlined
              color="white"
              min-height="200px"
            >
              {{ textBlock.text }}
            </v-card>
          </v-card>
        </v-col>
      </transition-group>
      <v-container v-else class="no-block-display-container">
        <v-row justify="center">
          <div class="font-bold text-2xl opacity-50">
            社員のテキストブロックがありません
          </div>
        </v-row>
      </v-container>
    </div>

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
    user: {
      type: Object,
      required: false,
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
    isMyTextBlocksLengthNotZeroAndisThisShowPage() {},
    isMyTextBlocksLengthNotZero() {
      return this.myTextBlocks.length !== 0 ? true : false;
    },
    myTextBlocks() {
      return (
        this.textBlocks.filter(
          (textBlock) =>
            textBlock.profile_block.id == this.user.profile_block.id
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

<style scoped>
.v-enter-active,
.v-leave-active {
  transition: opacity 1s;
}

.v-enter,
.v-leave-to {
  opacity: 0;
}

.block-title {
  color: #80cbc4; /* 文字色 */
  padding: 10px 10px 10px 60px; /* 上・右・下・左の余白 */
  position: relative;
  font-size: 2rem;
  margin: 0.5rem;
}

.block-title:after {
  border-bottom: 2px dotted #80cbc4; /* 下線 */
  content: "";
  position: absolute;
  bottom: 0px;
  left: 0px;
  width: 100%;
}

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

.no-block-display-container {
  height: 300px;
}
</style>
