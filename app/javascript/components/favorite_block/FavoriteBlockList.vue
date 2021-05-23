<template>
  <v-container
    class="bg-brown-200 mb-10"
    v-show="isMyFavoriteBlocksLengthNotZero || isThisEditPage"
  >
    <div class="text-center text-5xl text-white py-5 my-5 top-sub-title">
      <span class="text-brown-300 rounded-full px-2 bg-white">F</span>
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
    <div>
      <transition-group
        tag="v-row"
        name="list"
        v-if="isMyFavoriteBlocksLengthNotZero"
      >
        <v-col
          v-for="favoriteBlock in myFavoriteBlocks"
          :key="favoriteBlock.id"
          cols="12"
          sm="3"
          class="border-b-2 border-brown-400 border-dashed"
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
      <NoBlockContainer block-name="Favorite" v-else />
    </div>

    <FavoriteFormatDialog
      :is-shown-favorite-format-dialog="isShownFavoriteFormatDialog"
      :favorite-block-color="favoriteBlockColor"
      @close-favorite-format-dialog="closeFavoriteFormatDialog"
      @add-favorite-block="addFavoriteBlock"
    />
  </v-container>
</template>

<script>
// plugins
import axios from "axios";
import { mapState } from "vuex";

import FavoriteFormatDialog from "./FavoriteFormatDialog";
import FavoriteBlockCard from "./FavoriteBlockCard";
import ProgressBar from "../ProgressBar";
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
    };
  },
  mounted() {
    this.firstRead();
  },
  computed: {
    ...mapState("users", ["currentUser"]),
    isMyFavoriteBlocksLengthNotZeroAndisThisShowPage() {},
    isMyFavoriteBlocksLengthNotZero() {
      return this.myFavoriteBlocks.length !== 0 ? true : false;
    },
    percentageMyFavoriteBlocksLengt() {
      if (this.myFavoriteBlocks.length / 10 >= 1) return 100;
      return (this.myFavoriteBlocks.length / 10) * 100;
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
  methods: {
    async firstRead() {
      this.fetchFavoriteBlocks();
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
  },
};
</script>

<style scoped>

</style>
