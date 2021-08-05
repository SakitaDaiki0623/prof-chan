<template>
  <v-card
    v-show="isMyYesOrNoBlocksLengthNotZero || isThisEditPage"
    color="brown lighten-4"
    outlined
    class="mb-10 pa-5"
  >
    <div class="corner-title top-sub-title">
      <span class="yellow--text text--darken-3 rounded-full px-2 bg-white"
        >Y</span
      >
      Yes or No コーナー
    </div>
    <v-row v-show="isThisEditPage" justify="center" class="py-5">
      <v-col cols="12" sm="12" align="center">
        <v-btn
          id="add-yes-or-no-block-btn"
          tile
          :color="yesOrNoBlockColor"
          class="ma-2 white--text"
          @click="openYesOrNoFormatDialog"
        >
          <v-icon left> mdi-plus </v-icon>
          Yes or No ブロックを追加する
        </v-btn>
      </v-col>
      <v-col cols="12" sm="8" align="right">
        <ProgressBar
          :percentage-for-blocks="percentageMyYesOrNoBlocksLengt"
          :block-color="yesOrNoBlockColor"
        />
      </v-col>
    </v-row>
    <div class="text-center">
      <v-pagination
        v-show="isPageSizeBiggerThanMyYesOrNoBlocks && !isThisEditPage"
        v-model="page"
        :length="length"
        circle
        :color="yesOrNoBlockColor"
        class="mb-10"
        @input="pageChange"
      />
    </div>
    <div>
      <transition-group
        v-if="isMyYesOrNoBlocksLengthNotZero && !isThisEditPage"
        tag="v-row"
        name="list"
      >
        <v-col
          v-for="yesOrNoBlock in displayBlocks"
          :key="yesOrNoBlock.id"
          cols="12"
          md="6"
          lg="4"
          class="border-b-2 border-brown-300 border-dashed"
        >
          <YesOrNoBlockCard
            :yes-or-no-block="yesOrNoBlock"
            :is-this-edit-page="isThisEditPage"
            :yes-or-no-block-color="yesOrNoBlockColor"
          />
        </v-col>
      </transition-group>
      <transition-group
        v-else-if="isMyYesOrNoBlocksLengthNotZero && isThisEditPage"
        tag="v-row"
        name="list"
      >
        <v-col
          v-for="yesOrNoBlock in myYesOrNoBlocks"
          :key="yesOrNoBlock.id"
          cols="12"
          md="6"
          lg="4"
          class="border-b-2 border-brown-300 border-dashed"
        >
          <YesOrNoBlockCard
            :yes-or-no-block="yesOrNoBlock"
            :is-this-edit-page="isThisEditPage"
            :yes-or-no-block-color="yesOrNoBlockColor"
            :yes-or-no-items="yesOrNoItems"
            @retrieve-yes-or-no-block="retrieveYesOrNoBlock"
            @update-yes-or-no-block="updateYesOrNoBlock"
            @add-yes-or-no-item="addYesOrNoItem"
            @update-yes-or-no-item="updateYesOrNoItem"
            @retrieve-yes-or-no-item="retrieveYesOrNoItem"
          />
        </v-col>
      </transition-group>
      <NoBlockContainer v-else block-name="Yes or No " />
    </div>

    <YesOrNoFormatDialog
      :is-shown-yes-or-no-format-dialog="isShownYesOrNoFormatDialog"
      :yes-or-no-block-color="yesOrNoBlockColor"
      @close-yes-or-no-format-dialog="closeYesOrNoFormatDialog"
      @add-yes-or-no-block="addYesOrNoBlock"
    />
  </v-card>
</template>

<script>
import axios from "axios";
import { mapState, mapActions } from "vuex";

import YesOrNoFormatDialog from "./YesOrNoFormatDialog";
import YesOrNoBlockCard from "./YesOrNoBlockCard";
import ProgressBar from "../parts/ProgressBar";
import NoBlockContainer from "../static/NoBlockContainer";

export default {
  components: {
    YesOrNoFormatDialog,
    YesOrNoBlockCard,
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
      isShownYesOrNoFormatDialog: false,
      yesOrNoBlockColor: "orange lighten-3", // block color
      yesOrNoBlocks: [],
      yesOrNoItems: [],

      page: 1,
      displayBlocks: [],
      pageSize: 3,
      length: 0,
    };
  },
  computed: {
    ...mapState("users", ["currentUser"]),

    percentageMyYesOrNoBlocksLengt() {
      if (this.myYesOrNoBlocks.length / 5 >= 1) return 100;
      return (this.myYesOrNoBlocks.length / 5) * 100;
    },

    myYesOrNoBlocks() {
      return (
        this.yesOrNoBlocks.filter(
          (yesOrNoBlock) =>
            yesOrNoBlock.profile_block.id == this.user.profile_block.id
        ) || {}
      );
    },

    isPageSizeBiggerThanMyYesOrNoBlocks() {
      return this.myYesOrNoBlocks.length > this.pageSize ? true : false;
    },

    isMyYesOrNoBlocksLengthNotZero() {
      return this.myYesOrNoBlocks.length !== 0 ? true : false;
    },
  },
  mounted() {
    this.pageFirstRead();
  },
  methods: {
    openYesOrNoFormatDialog() {
      this.isShownYesOrNoFormatDialog = true;
    },
    closeYesOrNoFormatDialog() {
      this.isShownYesOrNoFormatDialog = false;
    },
    pageChange(pageNumber) {
      this.displayBlocks = this.myYesOrNoBlocks.slice(
        this.pageSize * (pageNumber - 1),
        this.pageSize * pageNumber
      );
    },
    async pageFirstRead() {
      await this.fetchYesOrNoBlocks();
      await this.fetchYesOrNoItems();
      this.length = Math.ceil(this.myYesOrNoBlocks.length / this.pageSize);
      this.displayBlocks = this.myYesOrNoBlocks.slice(0, this.pageSize);
    },

    async fetchYesOrNoBlocks() {
      await axios.get("/api/v1/yes_or_no_blocks").then((response) => {
        this.yesOrNoBlocks = response.data;
      });
    },
    async fetchYesOrNoItems() {
      await axios.get("/api/v1/yes_or_no_items").then((response) => {
        this.yesOrNoItems = response.data;
      });
    },

    addYesOrNoBlock(yesOrNoBlock) {
      this.yesOrNoBlocks.push(yesOrNoBlock);

      // 従属アイテムの追加
      yesOrNoBlock.yes_or_no_items.forEach((yesOrNoItem) =>
        this.yesOrNoItems.push(yesOrNoItem)
      );
    },
    retrieveYesOrNoBlock(yesOrNoBlock) {
      const index = this.yesOrNoBlocks.findIndex((yesOrNoBlock) => {
        return yesOrNoBlock.id == yesOrNoBlock.id;
      });
      this.yesOrNoBlocks.splice(index, 1);

      // 従属アイテムの削除
      this.yesOrNoItems = this.yesOrNoItems.filter(
        (yesOrNoItem) => yesOrNoItem.yes_or_no_block.id !== yesOrNoBlock.id
      );
    },
    updateYesOrNoBlock(block) {
      const index = this.yesOrNoBlocks.findIndex((yesOrNoBlock) => {
        return yesOrNoBlock.id == block.id;
      });
      this.yesOrNoBlocks.splice(index, 1, block);
    },

    addYesOrNoItem(yesOrNoItem) {
      this.yesOrNoItems.push(yesOrNoItem);

      // 作成したアイテムを持つYes or No ブロックのインデックス番号を取得
      const yesOrNoBlockIndex = this.yesOrNoBlocks.findIndex(
        (yesOrNoBlock) => yesOrNoBlock.id == yesOrNoItem.yes_or_no_block.id
      );

      this.yesOrNoBlocks[yesOrNoBlockIndex].yes_or_no_items.push(yesOrNoItem);
    },

    updateYesOrNoItem(block) {
      const yesOrNoItemsIndex = this.yesOrNoItems.findIndex((yesOrNoItem) => {
        return yesOrNoItem.id == block.id;
      });
      this.yesOrNoItems.splice(yesOrNoItemsIndex, 1, block);

      // 更新したアイテムを持つYes or No ブロックのインデックス番号を取得
      const yesOrNoBlockIndex = this.yesOrNoBlocks.findIndex(
        (yesOrNoBlock) => yesOrNoBlock.id == block.yes_or_no_block.id
      );

      // そのYes or No ブロック内の更新したアイテムのインデックス番号を取得
      const yesOrNoBlockItemsIndex = this.yesOrNoBlocks
        .find((yesOrNoBlock) => yesOrNoBlock.id == block.yes_or_no_block.id)
        .yes_or_no_items.findIndex((yesOrNoItem) => yesOrNoItem.id == block.id);

      this.yesOrNoBlocks[yesOrNoBlockIndex].yes_or_no_items.splice(
        yesOrNoBlockItemsIndex,
        1,
        block
      );
    },

    retrieveYesOrNoItem(block) {
      const index = this.yesOrNoItems.findIndex((yesOrNoItem) => {
        return yesOrNoItem.id == block.id;
      });
      this.yesOrNoItems.splice(index, 1);

      // 削除したアイテムを持つYes or No ブロックのインデックス番号を取得
      const yesOrNoBlockIndex = this.yesOrNoBlocks.findIndex(
        (yesOrNoBlock) => yesOrNoBlock.id == block.yes_or_no_block.id
      );

      // そのYes or No ブロック内の削除したアイテムのインデックス番号を取得
      const yesOrNoBlockItemsIndex = this.yesOrNoBlocks
        .find((yesOrNoBlock) => yesOrNoBlock.id == block.yes_or_no_block.id)
        .yes_or_no_items.findIndex((yesOrNoItem) => yesOrNoItem.id == block.id);

      this.yesOrNoBlocks[yesOrNoBlockIndex].yes_or_no_items.splice(
        yesOrNoBlockItemsIndex,
        1
      );
    },
  },
};
</script>
