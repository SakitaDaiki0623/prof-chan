<template>
  <v-container
    class="mb-10 bg-brown-200"
    v-show="isMyRankingBlocksLengthNotZero || isThisEditPage"
  >
    <div class="text-center text-5xl text-white py-5 my-5 top-sub-title">
      <span class="text-green-300 rounded-full px-2 bg-white">R</span> My Best 3
    </div>
    <v-row v-show="isThisEditPage" justify="center" class="py-5">
      <v-col cols="12" sm="12" align="center">
        <v-btn
          id="add-ranking-block-btn"
          tile
          :color="rankingBlockColor"
          class="ma-2 white--text"
          @click="openRankingFormatDialog"
        >
          <v-icon left> mdi-plus </v-icon>
          ランキングブロックを追加する
        </v-btn>
      </v-col>
      <v-col cols="12" sm="8" align="right">
        <ProgressBar
          :percentage-for-blocks="percentageMyRankingBlocksLengt"
          :block-color="rankingBlockColor"
        />
      </v-col>
    </v-row>
    <div class="text-center">
      <v-pagination
        v-model="page"
        :length="length"
        circle
        @input="pageChange"
        color="green lighten-3"
        class="mb-10"
        v-show="isPageSizeBiggerThanMyRankingBlocks && !isThisEditPage"
      ></v-pagination>
    </div>
    <div>
      <transition-group
        tag="v-row"
        name="list"
        v-if="isMyRankingBlocksLengthNotZero && !isThisEditPage"
      >
        <v-col
          v-for="rankingBlock in displayBlocks"
          :key="rankingBlock.id"
          cols="12"
          sm="4"
          class="border-b-2 border-brown-300 border-dashed"
        >
          <RankingBlockCard
            :ranking-block="rankingBlock"
            :is-this-edit-page="isThisEditPage"
            :ranking-block-color="rankingBlockColor"
          />
        </v-col>
      </transition-group>
      <transition-group
        tag="v-row"
        name="list"
        v-else-if="isMyRankingBlocksLengthNotZero && isThisEditPage"
      >
        <v-col
          v-for="rankingBlock in myRankingBlocks"
          :key="rankingBlock.id"
          cols="12"
          sm="4"
          class="border-b-2 border-brown-300 border-dashed"
        >
          <RankingBlockCard
            :ranking-block="rankingBlock"
            :is-this-edit-page="isThisEditPage"
            :ranking-block-color="rankingBlockColor"
            @update-ranking-block="updateRankingBlock"
            @retrieve-ranking-block="retrieveRankingBlock"
          />
        </v-col>
      </transition-group>
      <NoBlockContainer block-name="ランキング" v-else />
    </div>

    <RankingFormatDialog
      :is-shown-ranking-format-dialog="isShownRankingFormatDialog"
      :ranking-block-color="rankingBlockColor"
      @close-ranking-format-dialog="closeRankingFormatDialog"
      @add-ranking-block="addRankingBlock"
    />
  </v-container>
</template>

<script>
// plugins
import axios from "axios";

import RankingFormatDialog from "./RankingFormatDialog";
import RankingBlockCard from "./RankingBlockCard";
import ProgressBar from "../ProgressBar";
import NoBlockContainer from "../static/NoBlockContainer";

export default {
  components: {
    RankingFormatDialog,
    RankingBlockCard,
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
      isShownRankingFormatDialog: false,
      rankingBlockColor: "green lighten-3", // ranking block color
      rankingBlocks: [],

      // pagination
      page: 1,
      displayBlocks: [],
      pageSize: 3,
      length: 0,
    };
  },
  computed: {
    percentageMyRankingBlocksLengt() {
      if (this.myRankingBlocks.length / 5 >= 1) return 100;
      return (this.myRankingBlocks.length / 5) * 100;
    },
    isMyRankingBlocksLengthNotZero() {
      return this.myRankingBlocks.length !== 0 ? true : false;
    },
    myRankingBlocks() {
      return (
        this.rankingBlocks.filter(
          (rankingBlock) =>
            rankingBlock.profile_block.id == this.user.profile_block.id
        ) || {}
      );
    },
    isPageSizeBiggerThanMyRankingBlocks() {
      return this.myRankingBlocks.length > this.pageSize ? true : false;
    },
  },
  mounted() {
    this.firstRead();
  },
  methods: {
    async firstRead() {
      await this.fetchRankingBlocks();
      this.pageFirstRead();
    },
    async fetchRankingBlocks() {
      await axios
        .get("/api/v1/ranking_blocks")
        .then((res) => (this.rankingBlocks = res.data));
    },
    addRankingBlock(rankingBlock) {
      this.rankingBlocks.push(rankingBlock);
    },
    updateRankingBlock(rankingBlock) {
      const index = this.rankingBlocks.findIndex((block) => {
        return block.id == rankingBlock.id;
      });
      this.rankingBlocks.splice(index, 1, rankingBlock);
    },
    retrieveRankingBlock(rankingBlock) {
      const index = this.rankingBlocks.findIndex((block) => {
        return block.id == rankingBlock.id;
      });
      this.rankingBlocks.splice(index, 1);
    },
    openRankingFormatDialog() {
      this.isShownRankingFormatDialog = true;
    },
    closeRankingFormatDialog() {
      this.isShownRankingFormatDialog = false;
    },

    pageChange(pageNumber) {
      this.displayBlocks = this.myRankingBlocks.slice(
        this.pageSize * (pageNumber - 1),
        this.pageSize * pageNumber
      );
    },
    pageFirstRead() {
      this.length = Math.ceil(this.myRankingBlocks.length / this.pageSize);
      this.displayBlocks = this.myRankingBlocks.slice(0, this.pageSize);
    },
  },
};
</script>

<style scoped></style>
