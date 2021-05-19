<template>
  <v-container
    class="rounded-2xl"
    v-if="isMyQuestionBlocksLengthNotZero || isThisEditPage"
  >
    <v-row v-show="isThisEditPage" justify="center">
      <v-btn
        id="add-question-block-btn"
        tile
        :color="questionBlockColor"
        class="ma-2 white--text"
        @click="openQuestionFormatDialog"
      >
        <v-icon left>
          mdi-plus
        </v-icon>
        クエスチョンブロックを追加する
      </v-btn>
    </v-row>
    <v-row justify="end">
      <div class="block-title">
        質問コーナー
      </div>
    </v-row>
    <div>
      <transition-group
        tag="v-row"
        name="list"
        v-if="isMyQuestionBlocksLengthNotZero"
      >
        <v-col
          v-for="questionBlock in myQuestionBlocks"
          :key="questionBlock.id"
          cols="12"
          sm="4"
        >
          <QuestionBlockCard
            :question-block="questionBlock"
            :is-this-edit-page="isThisEditPage"
            :question-block-color="questionBlockColor"
          />
        </v-col>
      </transition-group>
      <v-container v-else class="no-block-display-container">
        <v-row justify="center">
          <div class="font-bold text-2xl opacity-50">
            社員のクエスチョンブロックがありません
          </div>
        </v-row>
      </v-container>
    </div>

    <QuestionFormatDialog
      :is-shown-question-format-dialog="isShownQuestionFormatDialog"
      :question-block-color="questionBlockColor"
      @close-question-format-dialog="closeQuestionFormatDialog"
    />
  </v-container>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions } from "vuex";

import QuestionFormatDialog from "./QuestionFormatDialog";
import QuestionBlockCard from "./QuestionBlockCard";

export default {
  components: {
    QuestionFormatDialog,
    QuestionBlockCard,
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
      isShownQuestionFormatDialog: false,
      questionBlockColor: "red lighten-3", // question block color
    };
  },
  computed: {
    ...mapState("questionBlocks", ["questionBlocks"]),
    ...mapState("users", ["currentUser"]),

    myQuestionBlocks() {
      return (
        this.questionBlocks.filter(
          (questionBlock) =>
            questionBlock.profile_block.id == this.user.profile_block.id
        ) || {}
      );
    },
    isMyQuestionBlocksLengthNotZero() {
      return this.myQuestionBlocks.length !== 0 ? true : false;
    },
  },
  methods: {
    openQuestionFormatDialog() {
      this.isShownQuestionFormatDialog = true;
    },
    closeQuestionFormatDialog() {
      this.isShownQuestionFormatDialog = false;
    },
  },
};
</script>

<style scoped>
.block-title {
  color: #ef9a9a;
  padding: 10px;
  position: relative;
  font-size: 2rem;
  margin: 0.5rem;
}

.block-title:after {
  background: repeating-linear-gradient(
    -45deg,
    #f0b8bf,
    #f0b8bf 6px,
    #fcf0f1 0,
    #fcf0f1 10px
  );
  content: "";
  height: 10px;
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 1;
}

.no-block-display-container {
  height: 300px;
}
</style>
