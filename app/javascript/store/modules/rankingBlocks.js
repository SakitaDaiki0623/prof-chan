// app/javascript/store/modules/rankingBlocks.js
import axios from "../../plugins/axios.js";

export const rankingBlocks = {
  namespaced: true,
  state: {
    rankingBlocks: [],
  },
  mutations: {
    loadRankingBlocks(state, rankingBlocks) {
      state.rankingBlocks = rankingBlocks;
    },
    addRankingBlock: (state, rankingBlock) => {
      state.rankingBlocks.push(rankingBlock);
    },
    updateRankingBlock(state, data) {
      const index = state.rankingBlocks.findIndex((rankingBlock) => {
        return rankingBlock.id == data.id;
      });
      state.rankingBlocks.splice(index, 1, data);
    },
    retrieveRankingBlock(state, data) {
      const index = state.rankingBlocks.findIndex((rankingBlock) => {
        return rankingBlock.id == data.id;
      });
      state.rankingBlocks.splice(index, 1);
    },
  },
  actions: {
    fetchRankingBlocks({ commit }) {
      axios
        .get("ranking_blocks")
        .then((response) => {
          commit("loadRankingBlocks", response.data);
        })
        .catch((error) => console.log(error.status));
    },
    createRankingBlock({ commit }, rankingBlock) {
      axios
        .post("ranking_blocks", rankingBlock)
        .then((response) => {
          commit("addRankingBlock", response.data);
        })
        .catch((err) => console.log(err.status));
    },
    patchRankingBlock({ commit }, payload) {
      axios
        .patch(`ranking_blocks/${payload.id}`, payload)
        .then((response) => {
          commit("updateRankingBlock", response.data);
        })
        .catch((err) => console.log(err));
    },
    deleteRankingBlock({ commit }, payload) {
      axios
        .delete(`ranking_blocks/${payload.id}`, payload)
        .then((response) => {
          commit("retrieveRankingBlock", response.data);
        })
        .catch((err) => console.log(err));
    },
  },
};
