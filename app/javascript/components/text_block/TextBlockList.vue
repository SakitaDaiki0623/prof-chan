<template>
  <v-container
    class="mb-10 bg-brown-200"
    v-show="isMyTextBlocksLengthNotZero || isThisEditPage"
  >
    <div class="text-center text-5xl text-white py-5 my-5 top-sub-title">
      <span class="text-blue-100 rounded-full px-2 bg-white">T</span>
      テキストコーナー
    </div>
    <v-row v-show="isThisEditPage" justify="center" class="py-5">
      <v-col cols="12" sm="12" align="center">
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
      </v-col>
      <v-col cols="12" sm="8" align="right">
        <ProgressBar
          :percentage-for-blocks="percentageMyTextBlocksLengt"
          :block-color="textBlockColor"
        />
      </v-col>
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
          class="border-b-2 border-brown-300 border-dashed"
        >
          <TextBlockCard
            :text-block="textBlock"
            :is-this-edit-page="isThisEditPage"
            :text-block-color="textBlockColor"
          />
        </v-col>
      </transition-group>
      <NoBlockContainer block-name="テキスト" v-else />
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
import ProgressBar from "../ProgressBar";
import NoBlockContainer from "../static/NoBlockContainer";

export default {
  components: {
    TextFormatDialog,
    TextBlockCard,
    ProgressBar,
    NoBlockContainer,
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
    percentageMyTextBlocksLengt() {
      if (this.myTextBlocks.length / 2 >= 1) return 100;
      return (this.myTextBlocks.length / 2) * 100;
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


</style>
