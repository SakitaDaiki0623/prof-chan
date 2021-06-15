<template>
  <div>
    <v-card
      class="rounded-2xl pa-5 note-box"
      outlined
      color="light-green lighten-4"
    >
      <v-row
        v-if="isThisEditPage"
        justify="end"
      >
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
        />
      </v-row>
      <p class="text-2xl font-bold text-gray-600 px-3 pt-3">
        {{ rankingBlock.title }}
      </p>
      <v-card
        class="pa-2 ma-3 rounded-full"
        outlined
        color="white"
      >
        <label
          for="1st place"
          class="form-label-text-block mr-5"
        >1st</label>{{ rankingBlock.first_place }}
      </v-card>
      <v-card
        class="pa-2 ma-3 rounded-full"
        outlined
        color="white"
      >
        <label
          for="2nd place"
          class="form-label-text-block mr-5"
        >2nd</label>{{ rankingBlock.second_place }}
      </v-card>
      <v-card
        class="pa-2 ma-3 rounded-full"
        outlined
        color="white"
      >
        <label
          for="3rd place"
          class="form-label-text-block mr-5"
        >3rd</label>{{ rankingBlock.third_place }}
      </v-card>
    </v-card>
    <EditRankingFormatDialog
      v-if="isThisEditPage"
      :is-shown-edit-ranking-format-dialog="isShownEditRankingFormatDialog"
      :ranking-block-color="rankingBlockColor"
      :edit-ranking-block="editRankingBlock"
      @close-edit-ranking-format-dialog="closeEditRankingFormatDialog"
      @update-ranking-block="$listeners['update-ranking-block']"
    />
  </div>
</template>

<script>
import axios from "axios";

import EditRankingFormatDialog from "./EditRankingFormatDialog";
import RankingBlockLikeButton from "../likes/RankingBlockLikeButton";

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
    deleteRankingBlock(rankingBlock) {
      axios
        .delete(`/api/v1/ranking_blocks/${rankingBlock.id}`, rankingBlock)
        .then((res) => this.$emit("retrieve-ranking-block", res.data));
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
  border-right: dotted 10px #d7ccc8; /*ドットの大きさ、高さ*/
  height: 90%;
  top: 0.5em; /*位置*/
  left: 0.5em; /*位置*/
}
</style>
