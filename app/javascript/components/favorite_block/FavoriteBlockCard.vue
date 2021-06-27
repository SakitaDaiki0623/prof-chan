<template>
  <div>
    <v-card class="rounded-2xl pa-5" outlined :color="favoriteBlockColor">
      <v-row v-if="isThisEditPage" justify="end">
        <v-btn
          :id="'edit-text-block-button-' + favoriteBlock.id"
          tile
          small
          color="brown lighten-4"
          @click="openEditFavoriteFormatDialog(favoriteBlock)"
        >
          <v-icon> mdi-pencil </v-icon>
        </v-btn>
        <v-btn
          :id="'delete-text-block-button-' + favoriteBlock.id"
          tile
          small
          color="brown lighten-1"
          @click="hundleDeleteFavoriteBlock(favoriteBlock)"
        >
          <v-icon> mdi-delete </v-icon>
        </v-btn>
      </v-row>
      <v-row v-else>
        <v-spacer />
        <favorite-block-like-button
          :favorite-block-id="favoriteBlock.id"
          v-if="isThisNotTopPage"
        />
      </v-row>
      <label class="form-label">
        {{ favoriteBlock.title }}
      </label>
      <v-card
        class="pa-3 rounded-lg text-center"
        outlined
        color="white"
      >
        {{ favoriteBlock.text }}
      </v-card>
    </v-card>
    <EditFavoriteFormatDialog
      v-if="isThisEditPage"
      :is-shown-edit-favorite-format-dialog="isShownEditFavoriteFormatDialog"
      :favorite-block-color="favoriteBlockColor"
      :edit-favorite-block="editFavoriteBlock"
      @close-edit-favorite-format-dialog="closeEditFavoriteFormatDialog"
      @update-favorite-block="$listeners['update-favorite-block']"
    />
  </div>
</template>

<script>
import FavoriteBlockLikeButton from "../likes/FavoriteBlockLikeButton";
import EditFavoriteFormatDialog from "./EditFavoriteFormatDialog";

import { mapActions } from "vuex";
import axios from "axios";

export default {
  components: {
    FavoriteBlockLikeButton,
    EditFavoriteFormatDialog,
  },
  props: {
    favoriteBlock: {
      type: Object,
      requred: true,
    },
    isThisEditPage: {
      type: Boolean,
      required: false,
      default: false,
    },
    favoriteBlockColor: {
      type: String,
      requred: false,
      default: "brown lighten-3",
    },
  },
  data() {
    return {
      isShownEditFavoriteFormatDialog: false,
      editFavoriteBlock: {},
    };
  },
  computed: {
    isThisNotTopPage() {
      return this.$route.path == `/top` ? false : true;
    },
  },
  methods: {
    openEditFavoriteFormatDialog(favoriteBlock) {
      this.editFavoriteBlock = Object.assign({}, favoriteBlock);
      this.isShownEditFavoriteFormatDialog = true;
    },
    closeEditFavoriteFormatDialog() {
      this.isShownEditFavoriteFormatDialog = false;
    },
    hundleDeleteFavoriteBlock(favoriteBlock) {
      if (!confirm("削除してよろしいですか?")) return;
      this.deleteFavoriteBlock(favoriteBlock);
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "Favorite ブロックを削除したよ！",
        color: this.favoriteBlockColor,
      });
    },
    deleteFavoriteBlock(favoriteBlock) {
      axios
        .delete(`/api/v1/favorite_blocks/${favoriteBlock.id}`, favoriteBlock)
        .then((res) => this.$emit("retrieve-favorite-block", res.data));
    },
  },
};
</script>

