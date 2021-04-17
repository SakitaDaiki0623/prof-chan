<!-- app/javascript/pages/profile/show.vue -->
<template>
  <div class="bg-backimage-02 bg-cover text-gray-600 font-prof-default">
    <p class="text-5xl font-bold note mb-10">プロフィール編集</p>

    <!-- Basic Prof Card -->
    <div class="flex justify-center mb-10">
      <BasicProfCard
        :profile="profile"
        @open-edit-basic-prof-card="openEditBasicProfCard"
      />
    </div>
    <!-- /Basic Prof Card -->

    <!-- Text Blocks -->
    <v-row justify="center" class="mb-10">
      <v-btn
        id="add-text-block-btn"
        tile
        color="teal lighten-3"
        class="ma-2 white--text"
        @click="openTextFormatDialog"
      >
        <v-icon left> mdi-plus </v-icon>
        テキストブロックを追加する
      </v-btn>
    </v-row>
    <TextProfCardList
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
        color="red lighten-3"
        class="ma-2 white--text"
        @click="openQuestionBlockSelectDialog"
      >
        <v-icon left> mdi-plus </v-icon>
        クエスチョンブロックを追加する
      </v-btn>
    </v-row>

    <!-- Dialogs -->
    <!-- Basic Prof Card -->
    <EditBasicProfCardDialog
      :is-shown-edit-basic-prof-card-dialog="isShownEditBasicProfCardDialog"
    />

    <!-- Question Block -->
    <QuestionBlockSelectDialog
      :is-shown-question-block-select-dialog="isShownQuestionBlockSelectDialog"
      @open-question-format-dialog="openQuestionFormatDialog"
    />
    <QuestionFormatDialog
      :is-shown-question-format-dialog="isShownQuestionFormatDialog"
      @close-question-format-dialog="closeQuestionFormatDialog"
    />

    <!-- Text Block -->
    <TextFormatDialog
      :is-shown-text-format-dialog="isShownTextFormatDialog"
      :textBlockColorForFlashMessage="textBlockColorForFlashMessage"
      @close-text-format-dialog="closeTextFormatDialog"
    />
    <EditTextFormatDialog
      :is-shown-edit-text-format-dialog="isShownEditTextFormatDialog"
      :textBlockColorForFlashMessage="textBlockColorForFlashMessage"
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
import BasicProfCard from "../../components/BasicProfCard";
import EditBasicProfCardDialog from "../../components/EditBasicProfCardDialog";
import TextProfCardList from "../../components/TextProfCardList";
import TextFormatDialog from "../../components/TextFormatDialog";
import EditTextFormatDialog from "../../components/EditTextFormatDialog";
import QuestionFormatDialog from "../../components/QuestionFormatDialog";

import QuestionBlockSelectDialog from "../../components/QuestionBlockSelectDialog";

export default {
  components: {
    // Basic Prof Card
    BasicProfCard,
    EditBasicProfCardDialog,

    // Text Block
    TextFormatDialog,
    TextProfCardList,
    EditTextFormatDialog,

    // Question Block
    QuestionBlockSelectDialog,
    QuestionFormatDialog,
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
      textBlockColorForFlashMessage: "teal lighten-3", // text block image color

      // Question Block
      isShownQuestionBlockSelectDialog: false,
      isShownQuestionFormatDialog: false,
    };
  },
  computed: {
    ...mapState("profiles", ["profiles"]),
    ...mapState("users", ["currentUser"]),
    ...mapState("textBlocks", ["textBlocks"]),

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
  },
  mounted() {
    this.fetchProfiles();
    this.fetchTextBlocks();

    document.title = `プロフィール編集 - プロフちゃん`;
  },
  methods: {
    ...mapActions("profiles", ["fetchProfiles"]),
    ...mapActions("users", ["fetchCurrentUser"]),
    ...mapActions("textBlocks", ["fetchTextBlocks", "deleteTextBlock"]),

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
      this.deleteTextBlock(textBlock);
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "テキストブロックを削除したよ！",
        color: this.textBlockColorForFlashMessage,
      });
    },

    // Question Block
    openQuestionBlockSelectDialog() {
      this.isShownQuestionBlockSelectDialog = true;
    },
    closeQuestionBlockSelectDialog() {
      this.isShownQuestionBlockSelectDialog = false;
    },
    openQuestionFormatDialog() {
      this.closeQuestionBlockSelectDialog();
      this.isShownQuestionFormatDialog = true;
    },
    closeQuestionFormatDialog() {
      this.isShownQuestionFormatDialog = false;
    },
  },
};
</script>

<style scoped>
.note {
  width: 80%;
  padding: 0 1em;
  background: linear-gradient(#ccc 0.1px, transparent 0.6px) #fffbf2;
  background-size: auto 2.5em;
  line-height: 2.5em;
  border-bottom: 1px solid #ccc;
  border-left: 1px solid #ccc;
  border-right: 1px solid #ccc;
  overflow: hidden;
}
</style>
