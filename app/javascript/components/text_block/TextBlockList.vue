<template>
  <v-card
    v-show="isMyTextBlocksLengthNotZero || isThisEditPage"
    color="brown lighten-4"
    outlined
    class="mb-10 pa-5"
  >
    <div class="corner-title top-sub-title">
      <span
        class="blue--text text--lighten-3 rounded-full px-2 bg-white"
      >T</span>
      テキストコーナー
    </div>
    <v-row
      v-show="isThisEditPage"
      justify="center"
      class="py-5"
    >
      <v-col
        cols="12"
        sm="12"
        align="center"
      >
        <v-btn
          id="add-text-block-btn"
          tile
          :color="textBlockColor"
          class="ma-2 white--text"
          @click="openTextFormatDialog"
        >
          <v-icon left>
            mdi-plus
          </v-icon>
          テキストブロックを追加する
        </v-btn>
      </v-col>
      <v-col
        cols="12"
        sm="8"
        align="right"
      >
        <ProgressBar
          :percentage-for-blocks="percentageMyTextBlocksLengt"
          :block-color="textBlockColor"
        />
      </v-col>
    </v-row>
    <div class="text-center">
      <v-pagination
        v-show="isPageSizeBiggerThanMyTextBlocks && !isThisEditPage"
        v-model="page"
        :length="length"
        circle
        :color="textBlockColor"
        class="mb-10"
        @input="pageChange"
      />
    </div>
    <div>
      <transition-group
        v-if="isMyTextBlocksLengthNotZero && !isThisEditPage"
        tag="v-row"
        name="list"
      >
        <v-col
          v-for="textBlock in displayBlocks"
          :key="textBlock.id"
          cols="12"
          md="6"
          xl="4"
          class="border-b-2 border-brown-300 border-dashed"
        >
          <TextBlockCard
            :text-block="textBlock"
            :is-this-edit-page="isThisEditPage"
            :text-block-color="textBlockColor"
          />
        </v-col>
      </transition-group>
      <transition-group
        v-else-if="isMyTextBlocksLengthNotZero && isThisEditPage"
        tag="v-row"
        name="list"
      >
        <v-col
          v-for="textBlock in myTextBlocks"
          :key="textBlock.id"
          cols="12"
          md="6"
          xl="4"
          class="border-b-2 border-brown-300 border-dashed"
        >
          <TextBlockCard
            :text-block="textBlock"
            :is-this-edit-page="isThisEditPage"
            :text-block-color="textBlockColor"
            @update-text-block="updateTextBlock"
            @retrieve-text-block="retrieveTextBlock"
          />
        </v-col>
      </transition-group>
      <NoBlockContainer
        v-else
        block-name="テキスト"
      />
    </div>

    <TextFormatDialog
      :is-shown-text-format-dialog="isShownTextFormatDialog"
      :text-block-color="textBlockColor"
      @close-text-format-dialog="closeTextFormatDialog"
      @add-text-block="addTextBlock"
      @open-text-format-dialog="openTextFormatDialog"
    />
  </v-card>
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
      textBlockColor: "cyan lighten-3", // text block color
      textBlocks: [],

      // pagination
      page: 1,
      displayBlocks: [],
      pageSize: 2,
      length: 0,
    };
  },
  computed: {
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
    isPageSizeBiggerThanMyTextBlocks() {
      return this.myTextBlocks.length > this.pageSize ? true : false;
    },
  },
  mounted() {
    this.firstRead();
  },
  methods: {
    async firstRead() {
      await this.fetchTextBlocks();
      this.pageFirstRead();
    },
    async fetchTextBlocks() {
      await axios
        .get("/api/v1/text_blocks")
        .then((res) => (this.textBlocks = res.data));
    },
    openTextFormatDialog() {
      this.isShownTextFormatDialog = true;
    },
    closeTextFormatDialog() {
      this.isShownTextFormatDialog = false;
    },
    addTextBlock(textBlock) {
      this.textBlocks.push(textBlock);
    },
    updateTextBlock(textBlock) {
      const index = this.textBlocks.findIndex((block) => {
        return block.id == textBlock.id;
      });
      this.textBlocks.splice(index, 1, textBlock);
    },
    retrieveTextBlock(textBlock) {
      const index = this.textBlocks.findIndex((block) => {
        return block.id == textBlock.id;
      });
      this.textBlocks.splice(index, 1);
    },

    pageChange(pageNumber) {
      this.displayBlocks = this.myTextBlocks.slice(
        this.pageSize * (pageNumber - 1),
        this.pageSize * pageNumber
      );
    },
    pageFirstRead() {
      this.length = Math.ceil(this.myTextBlocks.length / this.pageSize);
      this.displayBlocks = this.myTextBlocks.slice(0, this.pageSize);
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
