<!-- app/javascript/pages/profile/show.vue -->
<template>
  <div class="text-gray-600">
    <p class="text-5xl font-bold note mb-10">プロフィール編集</p>

    <!-- Basic Prof Card -->
    <div class="mb-10">
      <BasicProfCard
        :profile="profile"
        @open-edit-basic-prof-card="openEditBasicProfCard"
      />
    </div>

    <!-- Text Blocks -->
    <v-row justify="center" class="mb-10">
      <v-btn
        id="add-text-block-btn"
        tile
        :color="textBlockColor"
        class="ma-2 white--text"
        @click="openTextFormatDialog"
      >
        <v-icon left> mdi-plus </v-icon>
        テキストブロックを追加する
      </v-btn>
    </v-row>
    <TextBlockList
      :my-text-blocks="myTextBlocks"
      class="mb-10"
      @open-edit-text-format-dialog="openEditTextFormatDialog"
      @delete-text-block="hundleDeleteTextBlock"
    />

    <!-- Questioin Blocks -->
    <v-row justify="center" class="mb-10">
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
      class="mb-10"
      @open-edit-question-format-dialog="openEditQuestionFormatDialog"
      @delete-question-block="hundleDeleteQuestionBlock"
    />

    <!-- YesOrNo Blocks -->
    <v-row justify="center" class="mb-10">
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

    <!-- Ranking Blocks -->
    <v-row justify="center" class="mb-10">
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
    <RankingBlockList
      class="mb-10"
      :my-ranking-blocks="myRankingBlocks"
      @open-edit-ranking-format-dialog="openEditRankingFormatDialog"
      @delete-ranking-block="hundleDeleteRankingBlock"
    />

    <!-- Dialogs -->
    <!-- Basic Prof Card -->
    <EditBasicProfCardDialog
      :is-shown-edit-basic-prof-card-dialog="isShownEditBasicProfCardDialog"
    />

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

    <!-- Ranking Block -->
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

    <!-- Text Block -->
    <TextFormatDialog
      :is-shown-text-format-dialog="isShownTextFormatDialog"
      :text-block-color="textBlockColor"
      @close-text-format-dialog="closeTextFormatDialog"
    />
    <EditTextFormatDialog
      :is-shown-edit-text-format-dialog="isShownEditTextFormatDialog"
      :text-block-color="textBlockColor"
      :edit-text-block="editTextBlock"
      @close-edit-text-format-dialog="closeEditTextFormatDialog"
    />
    <!-- /Dialogs -->
  </div>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions, Store } from "vuex";

// components ----------
// Basic Prof Card
import BasicProfCard from "../../components/BasicProfCard";
import EditBasicProfCardDialog from "../../components/EditBasicProfCardDialog";

// Text Block
import TextBlockList from "../../components/text_block/TextBlockList";
import TextFormatDialog from "../../components//text_block/TextFormatDialog";
import EditTextFormatDialog from "../../components/text_block/EditTextFormatDialog";

// Question Block
import QuestionBlockList from "../../components/question_block/QuestionBlockList";
import QuestionFormatDialog from "../../components/question_block/QuestionFormatDialog";
import EditQuestionFormatDialog from "../../components/question_block/EditQuestionFormatDialog";

// Ranking Block
import RankingFormatDialog from "../../components//ranking_block/RankingFormatDialog";
import RankingBlockList from "../../components//ranking_block/RankingBlockList";
import EditRankingFormatDialog from "../../components//ranking_block/EditRankingFormatDialog";

export default {
  components: {
    // Basic Prof Card
    BasicProfCard,
    EditBasicProfCardDialog,

    // Question Block
    QuestionBlockList,
    QuestionFormatDialog,
    EditQuestionFormatDialog,

    // Ranking Block
    RankingFormatDialog,
    RankingBlockList,
    EditRankingFormatDialog,

    // Text Block
    TextFormatDialog,
    TextBlockList,
    EditTextFormatDialog,
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
      // Basic Prof Card
      isShownEditBasicProfCardDialog: false,

      // Text Block
      isShownTextFormatDialog: false,
      isShownEditTextFormatDialog: false,
      editTextBlock: {},
      textBlockColor: "teal lighten-3", // text block image color

      // Question Block
      isShownQuestionFormatDialog: false,
      isShownEditQuestionFormatDialog: false,
      editQuestionBlock: {},
      questionBlockColor: "red lighten-3", // question block image color

      // YesOrNo Block
      isShownYesOrNoFormatDialog: false,
      isShownEditYesOrNoFormatDialog: false,
      editYesOrNoBlock: {},
      yesOrNoBlockColor: "orange lighten-3", // ranking block image color

      // Ranking Block
      isShownRankingFormatDialog: false,
      isShownEditRankingFormatDialog: false,
      editRankingBlock: {},
      rankingBlockColor: "green lighten-3", // ranking block image color
    };
  },
  computed: {
    ...mapState("profiles", ["profiles"]),
    ...mapState("users", ["currentUser"]),
    ...mapState("textBlocks", ["textBlocks"]),
    ...mapState("rankingBlocks", ["rankingBlocks"]),
    ...mapState("questionBlocks", ["questionBlocks"]),

    profile() {
      return this.profiles.find((profile) => profile.id == this.id) || {};
    },
    myTextBlocks() {
      return (
        this.textBlocks.filter(
          (textBlock) =>
            textBlock.profile_block.id == this.currentUser.profile_block.id
        ) || {}
      );
    },
    myRankingBlocks() {
      return (
        this.rankingBlocks.filter(
          (rankingBlock) =>
            rankingBlock.profile_block.id == this.currentUser.profile_block.id
        ) || {}
      );
    },
  },
  created() {
    // this.fetchProfiles();
    // this.fetchTextBlocks();
    // this.fetchQuestionBlocks();
    // this.fetchQuestionItems();
    this.fetchRankingBlocks();

    document.title = `プロフィール編集 - プロフちゃん`;
  },
  methods: {
    ...mapActions({
      fetchProfiles: "profiles/fetchProfiles",
      fetchCurrentUser: "users/fetchCurrentUser",

      // Question Block
      fetchQuestionBlocks: "questionBlocks/fetchQuestionBlocks",
      deleteQuestionBlock: "questionBlocks/deleteQuestionBlock",
      fetchQuestionItems: "questionBlocks/fetchQuestionItems",

      // Ranking Block
      fetchRankingBlocks: "rankingBlocks/fetchRankingBlocks",
      deleteRankingBlock: "rankingBlocks/deleteRankingBlock",

      // Text Block
      fetchTextBlocks: "textBlocks/fetchTextBlocks",
      deleteTextBlock: "textBlocks/deleteTextBlock",
    }),

    // Basic Prof Card
    openEditBasicProfCard(profile) {
      this.isShownEditBasicProfCardDialog = true;
    },

    // Text Block
    openTextFormatDialog() {
      this.isShownTextFormatDialog = true;
    },
    closeTextFormatDialog() {
      this.isShownTextFormatDialog = false;
    },
    openEditTextFormatDialog(textBlock) {
      this.editTextBlock = Object.assign({}, textBlock);
      this.isShownEditTextFormatDialog = true;
    },
    closeEditTextFormatDialog() {
      this.isShownEditTextFormatDialog = false;
    },
    hundleDeleteTextBlock(textBlock) {
      if (!confirm("削除してよろしいですか?")) return;
      this.deleteTextBlock(textBlock);
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "テキストブロックを削除したよ！",
        color: this.textBlockColor,
      });
    },

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
    closeRankingFormatDialog() {
      this.isShownYesOrNoFormatDialog = false;
    },

    // Ranking Block
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