<template>
  <v-card
    v-if="isMyQuestionBlocksLengthNotZero || isThisEditPage"
    color="brown lighten-4"
    outlined
    class="mb-10 pa-5"
  >
    <div class="corner-title top-sub-title">
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
        v-show="isPageSizeBiggerThanMyQuestionBlocks && !isThisEditPage"
        v-model="page"
        :length="length"
        circle
        :color="questionBlockColor"
        class="mb-10"
        @input="pageChange"
      />
    </div>

    <div>
      <!-- 詳細画面用 -->
      <transition-group
        v-if="isMyQuestionBlocksLengthNotZero && !isThisEditPage"
        tag="v-row"
        name="list"
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
        v-else-if="isMyQuestionBlocksLengthNotZero && isThisEditPage"
        tag="v-row"
        name="list"
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
            :question-items="questionItems"
            @retrieve-question-block="retrieveQuestionBlock"
            @update-question-block="updateQuestionBlock"
            @add-question-item="addQuestionItem"
            @update-question-item="updateQuestionItem"
            @retrieve-question-item="retrieveQuestionItem"
          />
        </v-col>
      </transition-group>

      <NoBlockContainer v-else block-name="クエスチョン" />
    </div>

    <QuestionFormatDialog
      :is-shown-question-format-dialog="isShownQuestionFormatDialog"
      :question-block-color="questionBlockColor"
      @close-question-format-dialog="closeQuestionFormatDialog"
      @add-question-block="addQuestionBlock"
    />
  </v-card>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";

import QuestionFormatDialog from "./QuestionFormatDialog";
import QuestionBlockCard from "./QuestionBlockCard";
import ProgressBar from "../parts/ProgressBar";
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
      questionBlocks: [],
      questionItems: [],

      page: 1,
      displayBlocks: [],
      pageSize: 3,
      length: 0,
    };
  },
  computed: {
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
    async fetchQuestionBlocks() {
      await axios.get("/api/v1/question_blocks").then((response) => {
        this.questionBlocks = response.data;
      });
    },
    async fetchQuestionItems() {
      await axios.get("/api/v1/question_items").then((response) => {
        this.questionItems = response.data;
      });
    },
    addQuestionBlock(questionBlock) {
      this.questionBlocks.push(questionBlock);
      questionBlock.question_items.forEach((questionItem) =>
        this.questionItems.push(questionItem)
      );
    },

    retrieveQuestionBlock(block) {
      const index = this.questionBlocks.findIndex((questionBlock) => {
        return questionBlock.id == block.id;
      });
      this.questionBlocks.splice(index, 1);

      // 従属アイテムの削除
      this.questionItems = this.questionItems.filter(
        (questionItem) => questionItem.question_block.id !== block.id
      );
    },

    updateQuestionBlock(block) {
      const index = this.questionBlocks.findIndex((questionBlock) => {
        return questionBlock.id == block.id;
      });
      this.questionBlocks.splice(index, 1, block);
    },

    addQuestionItem(questionItem) {
      this.questionItems.push(questionItem);

      // 作成したアイテムを持つクエスチョンブロックのインデックス番号を取得
      const questionBlockIndex = this.questionBlocks.findIndex(
        (questionBlock) => questionBlock.id == questionItem.question_block.id
      );

      this.questionBlocks[questionBlockIndex].question_items.push(questionItem);
    },

    updateQuestionItem(block) {
      const questionItemsIndex = this.questionItems.findIndex(
        (questionItem) => {
          return questionItem.id == block.id;
        }
      );
      this.questionItems.splice(questionItemsIndex, 1, block);

      // 更新したアイテムを持つクエスチョンブロックのインデックス番号を取得
      const questionBlockIndex = this.questionBlocks.findIndex(
        (questionBlock) => questionBlock.id == block.question_block.id
      );

      // そのクエスチョンブロック内の更新したアイテムのインデックス番号を取得
      const questionBlockItemsIndex = this.questionBlocks
        .find((questionBlock) => questionBlock.id == block.question_block.id)
        .question_items.findIndex(
          (questionItem) => questionItem.id == block.id
        );

      this.questionBlocks[questionBlockIndex].question_items.splice(
        questionBlockItemsIndex,
        1,
        block
      );
    },

    retrieveQuestionItem(block) {
      const index = this.questionItems.findIndex((questionItem) => {
        return questionItem.id == block.id;
      });
      this.questionItems.splice(index, 1);

      // 削除したアイテムを持つクエスチョンブロックのインデックス番号を取得
      const questinBlockIndex = this.questionBlocks.findIndex(
        (questionBlock) => questionBlock.id == block.question_block.id
      );

      // そのクエスチョンブロック内の削除したアイテムのインデックス番号を取得
      const questionBlockItemsIndex = this.questionBlocks
        .find((questionBlock) => questionBlock.id == block.question_block.id)
        .question_items.findIndex(
          (questionItem) => questionItem.id == block.id
        );

      this.questionBlocks[questinBlockIndex].question_items.splice(
        questionBlockItemsIndex,
        1
      );
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
