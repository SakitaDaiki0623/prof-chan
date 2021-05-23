<template>
  <v-container
    class="mb-10 bg-brown-200"
    v-if="isMyQuestionBlocksLengthNotZero || isThisEditPage"
  >
    <div class="text-center text-5xl text-white py-5 my-5 top-sub-title">
      <span class="text-red-300 rounded-full px-2 bg-white">Q</span>質問コーナー
    </div>
    <v-row
      v-show="isThisEditPage"
      class="py-5"
      justify="center"
      align-content="center"
    >
      <v-col cols="12" sm="12" align="center">
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
      </v-col>
      <v-col cols="12" sm="8" align="right">
        <ProgressBar
          :percentage-for-blocks="percentageMyQuestionBlocksLengt"
          :block-color="questionBlockColor"
        />
      </v-col>
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
          class="border-b-2 border-red-300 border-dashed"
        >
          <QuestionBlockCard
            :question-block="questionBlock"
            :is-this-edit-page="isThisEditPage"
            :question-block-color="questionBlockColor"
          />
        </v-col>
      </transition-group>
      <NoBlockContainer block-name="クエスチョン" v-else />
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
import ProgressBar from "../ProgressBar";
import NoBlockContainer from "../static/NoBlockContainer";

export default {
  components: {
    QuestionFormatDialog,
    QuestionBlockCard,
    ProgressBar,
    NoBlockContainer,
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

    isMyQuestionBlocksLengthNotZero() {
      return this.myQuestionBlocks.length !== 0 ? true : false;
    },
    percentageMyQuestionBlocksLengt() {
      if (this.myQuestionBlocks.length / 5 >= 1) return 100;
      return (this.myQuestionBlocks.length / 5) * 100;
    },
    myQuestionBlocks() {
      return (
        this.questionBlocks.filter(
          (questionBlock) =>
            questionBlock.profile_block.id == this.user.profile_block.id
        ) || {}
      );
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


</style>
