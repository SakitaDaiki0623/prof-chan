<template>
  <v-container
    class="rounded-2xl bg-color"
    v-show="isMyRankingBlocksLengthNotZero || isThisEditPage"
  >
    <v-row v-show="isThisEditPage" justify="center">
      <v-btn
        id="add-ranking-block-btn"
        tile
        :color="rankingBlockColor"
        class="ma-2 white--text"
        @click="openRankingFormatDialog"
      >
        <v-icon left>
          mdi-plus
        </v-icon>
        ランキングブロックを追加する
      </v-btn>
    </v-row>
    <v-row justify="end">
      <div class="block-title">
        My Best 3
      </div>
    </v-row>
    <div>
      <transition-group
        tag="v-row"
        name="list"
        v-if="isMyRankingBlocksLengthNotZero"
      >
        <v-col
          v-for="rankingBlock in myRankingBlocks"
          :key="rankingBlock.id"
          cols="12"
          sm="4"
        >
          <RankingBlockCard
            :ranking-block="rankingBlock"
            :is-this-edit-page="isThisEditPage"
            :ranking-block-color="rankingBlockColor"
          />
        </v-col>
      </transition-group>
      <v-container v-else class="no-block-display-container">
        <v-row justify="center">
          <div class="font-bold text-2xl opacity-50">
            社員のランキングブロックがありません
          </div>
        </v-row>
      </v-container>
    </div>

    <RankingFormatDialog
      :is-shown-ranking-format-dialog="isShownRankingFormatDialog"
      :ranking-block-color="rankingBlockColor"
      @close-ranking-format-dialog="closeRankingFormatDialog"
    />
  </v-container>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions, Store } from "vuex";

import RankingFormatDialog from "./RankingFormatDialog";
import RankingBlockCard from "./RankingBlockCard";

export default {
  components: {
    RankingFormatDialog,
    RankingBlockCard,
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
      rankingBlockColor: "green lighten-4", // ranking block color
    };
  },
  computed: {
    ...mapState("rankingBlocks", ["rankingBlocks"]),
    ...mapState("users", ["currentUser"]),
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
  },
  methods: {
    openRankingFormatDialog() {
      this.isShownRankingFormatDialog = true;
    },
    closeRankingFormatDialog() {
      this.isShownRankingFormatDialog = false;
    },
  },
};
</script>

<style scoped>
.block-title {
  border: 1px solid #c5e1a5; /* 枠線 */
  border-right: 20px solid #c5e1a5; /* 右側の太い線 */
  box-shadow: 1px 1px 1px rgba(0, 0, 0, 0.1);
  color: #c5e1a5; /* 文字色 */
  padding: 10px 20px; /* 上下・左右の余白 */
  position: relative;
  font-size: 2rem;
  margin: 0.5rem;
}

.no-block-display-container {
  height: 300px;
}
</style>
