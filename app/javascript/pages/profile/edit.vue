<!-- app/javascript/pages/profile/edit.vue -->
<template>
  <div class="text-gray-600">
    <p class="text-5xl font-bold note mb-10">プロフィール編集</p>

    <!-- Basic Prof Card -->
    <BasicProfCard />

    <!-- My Favorites Blocks -->
    <MyFavoriteBlock />

    <!-- Text Blocks -->
    <TextBlockList />

    <!-- Questioin Blocks -->
    <v-row justify="center">
      <v-btn
        id="add-question-block-btn"
        tile
        :color="questionBlockColor"
        class="ma-2 white--text"
        @click="openQuestionFormatDialog"
      >
        <v-icon left> mdi-plus </v-icon>
        クエスチョンブロックを追加する
      </v-btn>
    </v-row>
    <QuestionBlockList
      @open-edit-question-format-dialog="openEditQuestionFormatDialog"
      @delete-question-block="hundleDeleteQuestionBlock"
    />

    <!-- YesOrNo Blocks -->
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

    <!-- Question Block -->
    <QuestionFormatDialog
      :is-shown-question-format-dialog="isShownQuestionFormatDialog"
      :question-block-color="questionBlockColor"
      @close-question-format-dialog="closeQuestionFormatDialog"
    />
    <EditQuestionFormatDialog
      :is-shown-edit-question-format-dialog="isShownEditQuestionFormatDialog"
      :edit-question-block="editQuestionBlock"
      :question-block-color="questionBlockColor"
      @close-question-block-format-dialog="closeEditQuestionFormatDialog"
      @close-question-block-edit-dialog="closeQuestionBlockEditDialog"
    />

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
import QuestionFormatDialog from "../../components/question_block/QuestionFormatDialog";
import EditQuestionFormatDialog from "../../components/question_block/EditQuestionFormatDialog";

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
    QuestionFormatDialog,
    EditQuestionFormatDialog,

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
      // Question Block
      isShownQuestionFormatDialog: false,
      isShownEditQuestionFormatDialog: false,
      editQuestionBlock: {},
      questionBlockColor: "red lighten-3", // question block color

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
    ...mapState("questionBlocks", ["questionBlocks"]),
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

      // Question Block
      fetchQuestionBlocks: "questionBlocks/fetchQuestionBlocks",
      deleteQuestionBlock: "questionBlocks/deleteQuestionBlock",
      fetchQuestionItems: "questionBlocks/fetchQuestionItems",
    }),

    // Question Block
    openQuestionFormatDialog() {
      this.isShownQuestionFormatDialog = true;
    },
    closeQuestionFormatDialog() {
      this.isShownQuestionFormatDialog = false;
    },
    openEditQuestionFormatDialog(questionBlock) {
      this.editQuestionBlock = Object.assign({}, questionBlock);
      this.isShownEditQuestionFormatDialog = true;
    },
    closeEditQuestionFormatDialog() {
      this.isShownEditQuestionFormatDialog = false;
    },
    closeQuestionBlockEditDialog(editQuestionBlock) {
      this.editQuestionBlock = editQuestionBlock;
    },
    hundleDeleteQuestionBlock(QuestionBlock) {
      if (!confirm("削除してよろしいですか?")) return;
      this.deleteQuestionBlock(QuestionBlock);
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "クエスチョンブロックを削除したよ！",
        color: "red lighten-3",
      });
    },

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
