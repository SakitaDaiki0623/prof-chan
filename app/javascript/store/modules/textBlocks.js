// app/javascript/store/modules/textBlocks.js
import axios from "../../plugins/axios.js";

export const textBlocks = {
  namespaced: true,
  state: {
    textBlocks: [],
  },
  mutations: {
    loadTextBlocks(state, textBlocks) {
      state.textBlocks = textBlocks;
    },
    addTextBlock: (state, textBlock) => {
      state.textBlocks.push(textBlock);
    },
    updateTextBlock(state, data) {
      const index = state.textBlocks.findIndex((textBlock) => {
        return textBlock.id == data.id;
      });
      state.textBlocks.splice(index, 1, data);
    },
    retrieveTextBlock(state, data) {
      const index = state.textBlocks.findIndex((textBlock) => {
        return textBlock.id == data.id;
      });
      state.textBlocks.splice(index, 1);
    },
  },
  actions: {
    fetchTextBlocks({ commit }) {
      axios
        .get("text_blocks")
        .then((response) => {
          commit("loadTextBlocks", response.data);
        })
        .catch((error) => console.log(error.status));
    },
    createTextBlock({ commit }, textBlock) {
      axios
        .post("text_blocks", textBlock)
        .then((response) => {
          commit("addTextBlock", response.data);
        })
        .catch((err) => console.log(err.status));
    },
    patchTextBlock({ commit }, payload) {
      axios
        .patch(`text_blocks/${payload.id}`, payload)
        .then((response) => {
          commit("updateTextBlock", response.data);
        })
        .catch((err) => console.log(err));
    },
    deleteTextBlock({ commit }, payload) {
      if (confirm("削除してよろしいですか?"))
        axios
          .delete(`text_blocks/${payload.id}`, payload)
          .then((response) => {
            commit("retrieveTextBlock", response.data);
          })
          .catch((err) => console.log(err));
    },
  },
};
