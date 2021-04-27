<!-- app/javascript/pages/profile/edit.vue -->
<template>
  <div class="text-gray-600">
    <p class="text-5xl font-bold note mb-10">プロフィール編集</p>

    <BasicProfCard />

    <MyFavoriteBlock />

    <TextBlockList />

    <QuestionBlockList />

    <v-row justify="center">
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
    </v-row>
    <YesOrNoBlockList
      @open-edit-yes-or-no-format-dialog="openEditYesOrNoFormatDialog"
      @delete-yes-or-no-block="hundleDeleteYesOrNoBlock"
    />

    <RankingBlockList />

    <!-- YesOrNo Block -->
    <YesOrNoFormatDialog
      :is-shown-yes-or-no-format-dialog="isShownYesOrNoFormatDialog"
      :yes-or-no-block-color="yesOrNoBlockColor"
      @close-yes-or-no-format-dialog="closeYesOrNoFormatDialog"
    />
    <EditYesOrNoFormatDialog
      :is-shown-edit-yes-or-no-format-dialog="isShownEditYesOrNoFormatDialog"
      :edit-yes-or-no-block="editYesOrNoBlock"
      :yes-or-no-block-color="yesOrNoBlockColor"
      @close-yes-or-no-block-format-dialog="closeEditYesOrNoFormatDialog"
      @close-yes-or-no-block-edit-dialog="closeYesOrNoBlockEditDialog"
    />
  </div>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions, Store } from "vuex";

// components ----------
import BasicProfCard from "../../components/basic_profile/BasicProfCard";

import MyFavoriteBlock from "../../components/my_favorites_block/MyFavoriteBlock";

import TextBlockList from "../../components/text_block/TextBlockList";

// Question Block
import QuestionBlockList from "../../components/question_block/QuestionBlockList";

// YesOrNo Block
import YesOrNoFormatDialog from "../../components/yes_or_no_block/YesOrNoFormatDialog";
import EditYesOrNoFormatDialog from "../../components/yes_or_no_block/EditYesOrNoFormatDialog";
import YesOrNoBlockList from "../../components/yes_or_no_block/YesOrNoBlockList";

// Ranking Block
import RankingBlockList from "../../components//ranking_block/RankingBlockList";

export default {
  components: {
    // Basic Prof Card
    BasicProfCard,

    // My Favorites Blocks
    MyFavoriteBlock,

    // Question Block
    QuestionBlockList,

    // YesOrNo Block
    YesOrNoFormatDialog,
    YesOrNoBlockList,
    EditYesOrNoFormatDialog,

    // Ranking Block
    RankingBlockList,

    // Text Block
    TextBlockList,
  },
  props: {
    id: {
      type: String,
      require: true,
      default: "",
    },
  },
  data() {
    return {
      // YesOrNo Block
      isShownYesOrNoFormatDialog: false,
      isShownEditYesOrNoFormatDialog: false,
      editYesOrNoBlock: {},
      yesOrNoBlockColor: "orange lighten-3", // ranking block color
    };
  },
  computed: {
    ...mapState("profiles", ["profiles"]),
    ...mapState("users", ["currentUser"]),
    ...mapState("yesOrNoBlocks", ["yesOrNoBlocks"]),
  },
  created() {
    // this.fetchProfiles();
    // this.fetchTextBlocks();
    // this.fetchQuestionBlocks();
    // this.fetchQuestionItems();
    // this.fetchRankingBlocks();
    // this.fetchYesOrNoBlocks();

    document.title = `プロフィール編集 - プロフちゃん`;
  },
  methods: {
    ...mapActions({
      fetchProfiles: "profiles/fetchProfiles",
      fetchCurrentUser: "users/fetchCurrentUser",

      // YesOrNo Block
      fetchYesOrNoBlocks: "yesOrNoBlocks/fetchYesOrNoBlocks",
      deleteYesOrNoBlock: "yesOrNoBlocks/deleteYesOrNoBlock",
      fetchYesOrNoItems: "yesOrNoBlocks/fetchYesOrNoItems",
    }),

    // YesOrNo Block
    openYesOrNoFormatDialog() {
      this.isShownYesOrNoFormatDialog = true;
    },
    closeYesOrNoFormatDialog() {
      this.isShownYesOrNoFormatDialog = false;
    },
    openEditYesOrNoFormatDialog(yesOrNoBlock) {
      this.editYesOrNoBlock = Object.assign({}, yesOrNoBlock);
      this.isShownEditYesOrNoFormatDialog = true;
    },
    closeEditYesOrNoFormatDialog() {
      this.isShownEditYesOrNoFormatDialog = false;
    },
    closeYesOrNoBlockEditDialog(editYesOrNoBlock) {
      this.editYesOrNoBlock = editYesOrNoBlock;
    },
    hundleDeleteYesOrNoBlock(yesOrNoBlock) {
      if (!confirm("削除してよろしいですか?")) return;
      this.deleteYesOrNoBlock(yesOrNoBlock);
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "Yes or No ブロックを削除したよ！",
        color: this.yesOrNoBlockColor,
      });
    },
  },
};
</script>
