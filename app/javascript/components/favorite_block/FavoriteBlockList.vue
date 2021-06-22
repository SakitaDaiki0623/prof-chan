<template>
  <v-card
    v-show="isMyFavoriteBlocksLengthNotZero || isThisEditPage"
    color="brown lighten-4"
    outlined
    class="mb-10 pa-5"
  >
    <div class="corner-title top-sub-title">
      <span class="brown--text text--lighten-3 rounded-full px-2 bg-white"
        >F</span
      >
      My Favorite コーナー
    </div>
    <v-row v-show="isThisEditPage" justify="center" class="py-5">
      <v-col cols="12" sm="12" align="center">
        <v-btn
          id="add-favorite-block-btn"
          tile
          :color="favoriteBlockColor"
          class="ma-2 white--text"
          @click="openFavoriteFormatDialog"
        >
          <v-icon left> mdi-plus </v-icon>
          Favorite ブロックを追加する
        </v-btn>
      </v-col>
      <v-col cols="12" sm="8" align="right">
        <ProgressBar
          :percentage-for-blocks="percentageMyFavoriteBlocksLengt"
          :block-color="favoriteBlockColor"
        />
      </v-col>
    </v-row>
    <div class="text-center">
      <v-pagination
        v-show="isPageSizeBiggerThanMyFavoriteBlocks && !isThisEditPage"
        v-model="page"
        :length="length"
        circle
        :color="favoriteBlockColor"
        class="mb-10"
        @input="pageChange"
      />
    </div>
    <div>
      <transition-group
        v-if="isMyFavoriteBlocksLengthNotZero && !isThisEditPage"
        tag="v-row"
        name="list"
      >
        <v-col
          v-for="favoriteBlock in displayBlocks"
          :key="favoriteBlock.id"
          cols="12"
          sm="6"
          md="4"
          lg="3"
          class="border-b-2 border-brown-300 border-dashed"
        >
          <FavoriteBlockCard
            :favorite-block="favoriteBlock"
            :is-this-edit-page="isThisEditPage"
            :favorite-block-color="favoriteBlockColor"
            @update-favorite-block="updateFavoriteBlock"
            @retrieve-favorite-block="retrieveFavoriteBlock"
          />
        </v-col>
      </transition-group>
      <transition-group
        v-else-if="isMyFavoriteBlocksLengthNotZero && isThisEditPage"
        tag="v-row"
        name="list"
      >
        <v-col
          v-for="favoriteBlock in myFavoriteBlocks"
          :key="favoriteBlock.id"
          cols="12"
          sm="6"
          md="4"
          lg="3"
          class="border-b-2 border-brown-300 border-dashed"
        >
          <FavoriteBlockCard
            :favorite-block="favoriteBlock"
            :is-this-edit-page="isThisEditPage"
            :favorite-block-color="favoriteBlockColor"
            @update-favorite-block="updateFavoriteBlock"
            @retrieve-favorite-block="retrieveFavoriteBlock"
          />
        </v-col>
      </transition-group>
      <NoBlockContainer v-else block-name="Favorite" />
    </div>

    <FavoriteFormatDialog
      :is-shown-favorite-format-dialog="isShownFavoriteFormatDialog"
      :favorite-block-color="favoriteBlockColor"
      @close-favorite-format-dialog="closeFavoriteFormatDialog"
      @add-favorite-block="addFavoriteBlock"
    />
  </v-card>
</template>

<script>
// plugins
import axios from "axios";

import FavoriteFormatDialog from "./FavoriteFormatDialog";
import FavoriteBlockCard from "./FavoriteBlockCard";
import ProgressBar from "../parts/ProgressBar";
import NoBlockContainer from "../static/NoBlockContainer";

export default {
  components: {
    FavoriteFormatDialog,
    FavoriteBlockCard,
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
      isShownFavoriteFormatDialog: false,
      favoriteBlockColor: "brown lighten-2",
      favoriteBlocks: [],

      // pagination
      page: 1,
      displayBlocks: [],
      pageSize: 8,
      length: 0,
    };
  },
  computed: {
    isMyFavoriteBlocksLengthNotZeroAndisThisShowPage() {},
    isMyFavoriteBlocksLengthNotZero() {
      return this.myFavoriteBlocks.length !== 0 ? true : false;
    },
    percentageMyFavoriteBlocksLengt() {
      if (this.myFavoriteBlocks.length / 10 > 1) return 100;
      return (this.myFavoriteBlocks.length / 10) * 100;
    },
    isPageSizeBiggerThanMyFavoriteBlocks() {
      return this.myFavoriteBlocks.length > this.pageSize ? true : false;
    },
    myFavoriteBlocks() {
      return (
        this.favoriteBlocks.filter(
          (favoriteBlock) =>
            favoriteBlock.profile_block.id == this.user.profile_block.id
        ) || {}
      );
    },
  },
  mounted() {
    this.firstRead();
  },
  methods: {
    async firstRead() {
      await this.fetchFavoriteBlocks();
      this.pageFirstRead();
    },
    async fetchFavoriteBlocks() {
      await axios
        .get("/api/v1/favorite_blocks")
        .then((res) => (this.favoriteBlocks = res.data));
    },
    openFavoriteFormatDialog() {
      this.isShownFavoriteFormatDialog = true;
    },
    closeFavoriteFormatDialog() {
      this.isShownFavoriteFormatDialog = false;
    },
    addFavoriteBlock(favoriteBlock) {
      this.favoriteBlocks.push(favoriteBlock);
    },
    updateFavoriteBlock(favoriteBlock) {
      const index = this.favoriteBlocks.findIndex((block) => {
        return block.id == favoriteBlock.id;
      });
      this.favoriteBlocks.splice(index, 1, favoriteBlock);
    },
    retrieveFavoriteBlock(favoriteBlock) {
      const index = this.favoriteBlocks.findIndex((block) => {
        return block.id == favoriteBlock.id;
      });
      this.favoriteBlocks.splice(index, 1);
    },

    pageChange(pageNumber) {
      this.displayBlocks = this.myFavoriteBlocks.slice(
        this.pageSize * (pageNumber - 1),
        this.pageSize * pageNumber
      );
    },
    pageFirstRead() {
      this.length = Math.ceil(this.myFavoriteBlocks.length / this.pageSize);
      this.displayBlocks = this.myFavoriteBlocks.slice(0, this.pageSize);
    },
  },
};
</script>

<style scoped></style>
