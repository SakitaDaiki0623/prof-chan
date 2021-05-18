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
      <transition-group
        tag="v-row"
        name="list"
        v-if="isMyTextBlocksLengthNotZero"
      >
        <v-col
          v-for="textBlock in myTextBlocks"
          :key="textBlock.id"
          cols="12"
          sm="6"
        >
          <TextBlockCard
            :text-block="textBlock"
            :is-this-edit-page="isThisEditPage"
            :text-block-color="textBlockColor"
          />
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
  </v-container>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions, Store } from "vuex";

import TextFormatDialog from "./TextFormatDialog";
import TextBlockCard from "./TextBlockCard";

export default {
  components: {
    TextFormatDialog,
    TextBlockCard,
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
    }),
    openTextFormatDialog() {
      this.isShownTextFormatDialog = true;
    },
    closeTextFormatDialog() {
      this.isShownTextFormatDialog = false;
    },
  },
};
</script>

<style scoped>
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

.no-block-display-container {
  height: 300px;
}
</style>
