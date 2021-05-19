<template>
  <div>
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
    <EditRankingFormatDialog
      :is-shown-edit-ranking-format-dialog="isShownEditRankingFormatDialog"
      :ranking-block-color="rankingBlockColor"
      :edit-ranking-block="editRankingBlock"
      @close-edit-ranking-format-dialog="closeEditRankingFormatDialog"
    />
  </div>
</template>

<script>
import EditRankingFormatDialog from "./EditRankingFormatDialog";
import RankingBlockLikeButton from "../likes/RankingBlockLikeButton";

import { mapActions } from "vuex";

export default {
  components: {
    EditRankingFormatDialog,
    RankingBlockLikeButton,
  },
  props: {
    rankingBlock: {
      type: Object,
      requred: true,
    },
    isThisEditPage: {
      type: Boolean,
      required: false,
      default: false,
    },
    rankingBlockColor: {
      type: String,
      requred: false,
      default: "green lighten-4",
    },
  },
  data() {
    return {
      isShownEditRankingFormatDialog: false,
      editRankingBlock: {},
    };
  },
  methods: {
    ...mapActions({
      deleteRankingBlock: "rankingBlocks/deleteRankingBlock",
    }),
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
</style>
