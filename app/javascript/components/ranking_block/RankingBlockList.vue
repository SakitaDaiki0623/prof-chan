<template>
  <v-container
    class="rounded-2xl bg-color"
    v-show="isMyRankingBlocksLengthNotZero || isThisEditPage"
  >
    <!-- Ranking Blocks -->
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
      <transition-group tag="v-row" name="list" v-if="isMyRankingBlocksLengthNotZero">
        <v-col
          v-for="rankingBlock in myRankingBlocks"
          :key="rankingBlock.id"
          cols="12"
          sm="4"
        >
          <v-card
            class="rounded-2xl p-5 note-box"
            outlined
            color="light-green lighten-5"
          >
            <v-row v-if="isThisEditPage" justify="end">
              <v-btn
                :id="'edit-ranking-block-button-' + rankingBlock.id"
                tile
                small
                color="green lighten-4"
                @click="openEditRankingFormatDialog(rankingBlock)"
              >
                <v-icon> mdi-pencil </v-icon>
              </v-btn>
              <v-btn
                :id="'delete-ranking-block-button-' + rankingBlock.id"
                tile
                small
                color="green lighten-1"
                @click="hundleDeleteRankingBlock(rankingBlock)"
              >
                <v-icon> mdi-delete </v-icon>
              </v-btn>
            </v-row>
            <v-row v-else>
              <v-spacer />
              <ranking-block-like-button
                :ranking-block-id="rankingBlock.id"
              ></ranking-block-like-button>
            </v-row>
            <p class="text-2xl font-bold text-gray-600 px-3 pt-3">
              {{ rankingBlock.title }}
            </p>
            <v-card class="p-2 m-3 rounded-full" outlined color="white">
              <label for="1st place" class="ranking-label">1st</label
              >{{ rankingBlock.first_place }}
            </v-card>
            <v-card class="p-2 m-3 rounded-full" outlined color="white">
              <label for="2nd place" class="ranking-label">2nd</label
              >{{ rankingBlock.second_place }}
            </v-card>
            <v-card class="p-2 m-3 rounded-full" outlined color="white">
              <label for="3rd place" class="ranking-label">3rd</label
              >{{ rankingBlock.third_place }}
            </v-card>
          </v-card>
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
    <EditRankingFormatDialog
      :is-shown-edit-ranking-format-dialog="isShownEditRankingFormatDialog"
      :ranking-block-color="rankingBlockColor"
      :edit-ranking-block="editRankingBlock"
      @close-edit-ranking-format-dialog="closeEditRankingFormatDialog"
    />
  </v-container>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions, Store } from "vuex";

import RankingFormatDialog from "./RankingFormatDialog";
import EditRankingFormatDialog from "./EditRankingFormatDialog";
import RankingBlockLikeButton from "../likes/RankingBlockLikeButton";

export default {
  components: {
    RankingFormatDialog,
    EditRankingFormatDialog,
    RankingBlockLikeButton,
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
      // Ranking Block
      isShownRankingFormatDialog: false,
      isShownEditRankingFormatDialog: false,
      editRankingBlock: {},
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
    ...mapActions({
      // Ranking Block
      fetchRankingBlocks: "rankingBlocks/fetchRankingBlocks",
      deleteRankingBlock: "rankingBlocks/deleteRankingBlock",
    }),
    openEditRankingFormatDialog(rankingBlock) {
      this.$emit("open-edit-ranking-format-dialog", rankingBlock);
    },
    openRankingFormatDialog() {
      this.isShownRankingFormatDialog = true;
    },
    closeRankingFormatDialog() {
      this.isShownRankingFormatDialog = false;
    },
    openEditRankingFormatDialog(rankingBlock) {
      this.editRankingBlock = Object.assign({}, rankingBlock);
      this.isShownEditRankingFormatDialog = true;
    },
    closeEditRankingFormatDialog() {
      this.isShownEditRankingFormatDialog = false;
    },
    hundleDeleteRankingBlock(rankingBlock) {
      if (!confirm("削除してよろしいですか?")) return;
      this.deleteRankingBlock(rankingBlock);
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "ランキングブロックを削除したよ！",
        color: this.rankingBlockColor,
      });
    },
  },
};
</script>

<style scoped>
/* .bg-color {
  background-color: #e4fcdd;
} */

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

.note-box {
  position: relative;
}
.note-box::before {
  content: "";
  position: absolute;
  border-right: dotted 10px #ddd; /*ドットの大きさ、高さ*/
  height: 90%;
  top: 0.5em; /*位置*/
  left: 0.5em; /*位置*/
}

.no-block-display-container {
  height: 300px;
}
</style>
