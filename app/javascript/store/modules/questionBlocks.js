// app/javascript/store/modules/questionBlocks.js
import axios from "../../plugins/axios.js";

export const questionBlocks = {
  namespaced: true,
  state: {
    questionBlocks: [],
  },
  mutations: {
    loadQuestionBlocks(state, questionBlocks) {
      state.questionBlocks = questionBlocks;
    },
    addQuestionBlock: (state, questionBlock) => {
      state.questionBlocks.push(questionBlock);
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
    },
  },
  actions: {
    fetchQuestionBlocks({ commit }) {
      axios
        .get("question_blocks")
        .then((response) => {
          commit("loadQuestionBlocks", response.data);
        })
        .catch((error) => console.log(error.status));
    },
    createQuestionBlock(
      { commit },
      { questionBlock, questionItem1, questionItem2, questionItem3 }
    ) {
      const params = {
        question_title: questionBlock.title,
        question_item_content1: questionItem1.content,
        question_item_answer1: questionItem1.answer,
        question_item_content2: questionItem2.content,
        question_item_answer2: questionItem2.answer,
        question_item_content3: questionItem3.content,
        question_item_answer3: questionItem3.answer,
      };
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
  },
};
