// app/javascript/store/modules/questionBlocks.js
import axios from "../../plugins/axios.js";

export const questionBlocks = {
  namespaced: true,
  state: {
    questionBlocks: [],
    questionItems: [],
  },
  mutations: {
    // Question Blocks ===========================
    loadQuestionBlocks(state, questionBlocks) {
      state.questionBlocks = questionBlocks;
    },
    addQuestionBlock: (state, questionBlock) => {
      state.questionBlocks.push(questionBlock);

      // 従属アイテムの追加
      questionBlock.question_items.forEach((questionItem) =>
        state.questionItems.push(questionItem)
      );
    },
    updateQuestionBlock(state, data) {
      const index = state.questionBlocks.findIndex((questionBlock) => {
        return questionBlock.id == data.id;
      });
      state.questionBlocks.splice(index, 1, data);
    },
    retrieveQuestionBlock(state, data) {
      const index = state.questionBlocks.findIndex((questionBlock) => {
        return questionBlock.id == data.id;
      });
      state.questionBlocks.splice(index, 1);

      // 従属アイテムの削除
      state.questionItems = state.questionItems.filter(
        (questionItem) => questionItem.question_block.id !== data.id
      );
    },

    // Question Items ===========================
    loadQuestionItems(state, questionItems) {
      state.questionItems = questionItems;
    },
    addQuestionItem: (state, questionItem) => {
      state.questionItems.push(questionItem);

      // 作成したアイテムを持つクエスチョンブロックのインデックス番号を取得
      const questionBlockIndex = state.questionBlocks.findIndex(
        (questionBlock) => questionBlock.id == questionItem.question_block.id
      );

      state.questionBlocks[questionBlockIndex].question_items.push(
        questionItem
      );
    },
    updateQuestionItem(state, data) {
      const questionItemsIndex = state.questionItems.findIndex(
        (questionItem) => {
          return questionItem.id == data.id;
        }
      );
      state.questionItems.splice(questionItemsIndex, 1, data);

      // 更新したアイテムを持つクエスチョンブロックのインデックス番号を取得
      const questionBlockIndex = state.questionBlocks.findIndex(
        (questionBlock) => questionBlock.id == data.question_block.id
      );

      // そのクエスチョンブロック内の更新したアイテムのインデックス番号を取得
      const questionBlockItemsIndex = state.questionBlocks
        .find((questionBlock) => questionBlock.id == data.question_block.id)
        .question_items.findIndex((questionItem) => questionItem.id == data.id);

      state.questionBlocks[questionBlockIndex].question_items.splice(
        questionBlockItemsIndex,
        1,
        data
      );
    },

    retrieveQuestionItem(state, data) {
      const index = state.questionItems.findIndex((questionItem) => {
        return questionItem.id == data.id;
      });
      state.questionItems.splice(index, 1);

      // 削除したアイテムを持つクエスチョンブロックのインデックス番号を取得
      const questinBlockIndex = state.questionBlocks.findIndex(
        (questionBlock) => questionBlock.id == data.question_block.id
      );

      // そのクエスチョンブロック内の削除したアイテムのインデックス番号を取得
      const questionBlockItemsIndex = state.questionBlocks
        .find((questionBlock) => questionBlock.id == data.question_block.id)
        .question_items.findIndex((questionItem) => questionItem.id == data.id);

      state.questionBlocks[questinBlockIndex].question_items.splice(
        questionBlockItemsIndex,
        1
      );
    },
  },
  actions: {
    // Question Blocks ===========================
    fetchQuestionBlocks({ commit }) {
      axios
        .get("question_blocks")
        .then((response) => {
          commit("loadQuestionBlocks", response.data);
        })
        .catch((error) => console.log(error.status));
    },
    createQuestionBlock({ commit }, params) {
      axios
        .post("question_blocks", params)
        .then((response) => {
          commit("addQuestionBlock", response.data);
        })
        .catch((err) => console.log(err.status));
    },
    patchQuestionBlock({ commit }, payload) {
      axios
        .patch(`question_blocks/${payload.id}`, payload)
        .then((response) => {
          commit("updateQuestionBlock", response.data);
        })
        .catch((err) => console.log(err));
    },

    deleteQuestionBlock({ commit }, payload) {
      axios
        .delete(`question_blocks/${payload.id}`, payload)
        .then((response) => {
          commit("retrieveQuestionBlock", response.data);
        })
        .catch((err) => console.log(err));
    },

    // Question Items ===========================
    fetchQuestionItems({ commit }) {
      axios
        .get("question_items")
        .then((response) => {
          commit("loadQuestionItems", response.data);
        })
        .catch((error) => console.log(error.status));
    },
    createQuestionItem({ commit }, questionItem) {
      axios
        .post("question_items", questionItem)
        .then((response) => {
          commit("addQuestionItem", response.data);
        })
        .catch((error) => console.log(error.status));
    },
    patchQuestionItem({ commit }, payload) {
      axios
        .patch(`question_items/${payload.id}`, payload)
        .then((response) => {
          commit("updateQuestionItem", response.data);
        })
        .catch((err) => console.log(err));
    },
    deleteQuestionItem({ commit }, payload) {
      axios
        .delete(`question_items/${payload.id}`, payload)
        .then((response) => {
          commit("retrieveQuestionItem", response.data);
        })
        .catch((err) => console.log(err));
    },
  },
};
