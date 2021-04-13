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
  },
};
