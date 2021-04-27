<template>
  <v-container class="mb-10">
    <!-- Ranking Blocks -->
    <v-row justify="center">
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
    </v-row>
    <v-row>
      <v-col
        v-for="rankingBlock in myRankingBlocks"
        :key="rankingBlock.id"
        cols="12"
        sm="6"
      >
        <v-card class="bg-ranking-prof-block bg-cover shadow rounded-2xl p-5">
          <v-row justify="end">
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
          <p class="text-2xl font-bold text-gray-600 pt-3">
            {{ rankingBlock.title }}
          </p>
          <v-card class="p-5 rounded-lg" outlined>
            {{ rankingBlock.first_place }}
          </v-card>
          <v-card class="p-5 rounded-lg" outlined>
            {{ rankingBlock.second_place }}
          </v-card>
          <v-card class="p-5 rounded-lg" outlined>
            {{ rankingBlock.third_place }}
          </v-card>
        </v-card>
      </v-col>
    </v-row>
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

export default {
  components: {
    RankingFormatDialog,
    EditRankingFormatDialog,
  },
  data() {
    return {
      // Ranking Block
      isShownRankingFormatDialog: false,
      isShownEditRankingFormatDialog: false,
      editRankingBlock: {},
      rankingBlockColor: "green lighten-3", // ranking block color
    };
  },
  computed: {
    ...mapState("rankingBlocks", ["rankingBlocks"]),
    ...mapState("users", ["currentUser"]),

    myRankingBlocks() {
      return (
        this.rankingBlocks.filter(
          (rankingBlock) =>
            rankingBlock.profile_block.id == this.currentUser.profile_block.id
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
