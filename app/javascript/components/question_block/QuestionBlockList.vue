<template>
  <v-card
    color="brown lighten-4"
    outlined
    class="mb-10 pa-5"
    v-if="isMyQuestionBlocksLengthNotZero || isThisEditPage"
  >
    <div class="text-center text-4xl text-white py-5 my-5 top-sub-title">
      <span class="red--text text--lighten-3 rounded-full px-2 bg-white">Q</span
      >質問コーナー
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
          <v-icon left> mdi-plus </v-icon>
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
    <div class="text-center">
      <v-pagination
        v-model="page"
        :length="length"
        circle
        @input="pageChange"
        :color="questionBlockColor"
        class="mb-10"
        v-show="isPageSizeBiggerThanMyQuestionBlocks && !isThisEditPage"
      ></v-pagination>
    </div>

    <div>
      <!-- 詳細画面用 -->
      <transition-group
        tag="v-row"
        name="list"
        v-if="isMyQuestionBlocksLengthNotZero && !isThisEditPage"
      >
        <v-col
          v-for="questionBlock in displayBlocks"
          :key="questionBlock.id"
          cols="12"
          md="6"
          lg="4"
          class="border-b-2 border-brown-300 border-dashed"
        >
          <QuestionBlockCard
            :question-block="questionBlock"
            :is-this-edit-page="isThisEditPage"
            :question-block-color="questionBlockColor"
          />
        </v-col>
      </transition-group>

      <!-- 編集画面用 -->
      <transition-group
        tag="v-row"
        name="list"
        v-else-if="isMyQuestionBlocksLengthNotZero && isThisEditPage"
      >
        <v-col
          v-for="questionBlock in myQuestionBlocks"
          :key="questionBlock.id"
          cols="12"
          md="6"
          lg="4"
          class="border-b-2 border-brown-300 border-dashed"
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
  </v-card>
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

      // pagination
      page: 1,
      displayBlocks: [],
      pageSize: 3,
      length: 0,
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
    isPageSizeBiggerThanMyQuestionBlocks() {
      return this.myQuestionBlocks.length > this.pageSize ? true : false;
    },
  },
  mounted() {
    this.pageFirstRead();
  },
  methods: {
    ...mapActions({
      fetchQuestionBlocks: "questionBlocks/fetchQuestionBlocks",
      fetchQuestionItems: "questionBlocks/fetchQuestionItems",
    }),
    openQuestionFormatDialog() {
      this.isShownQuestionFormatDialog = true;
    },
    closeQuestionFormatDialog() {
      this.isShownQuestionFormatDialog = false;
    },
    pageChange(pageNumber) {
      this.displayBlocks = this.myQuestionBlocks.slice(
        this.pageSize * (pageNumber - 1),
        this.pageSize * pageNumber
      );
    },
    async pageFirstRead() {
      await this.fetchQuestionBlocks();
      await this.fetchQuestionItems();
      this.length = Math.ceil(this.myQuestionBlocks.length / this.pageSize);
      this.displayBlocks = this.myQuestionBlocks.slice(0, this.pageSize);
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
