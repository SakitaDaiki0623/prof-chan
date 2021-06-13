// app/javascript/store/modules/users.js
import axios from "../../plugins/axios.js";

export const users = {
  namespaced: true,
  state: {
    currentUser: {},
  },
  getters: {
    currentUser: (state) => state.currentUser,
  },
  mutations: {
    loadCurrentUser(state, data) {
      state.currentUser = data;
    },
    updateCurrentUser(state, data) {
      state.currentUser = data;
    },
  },
  actions: {
    fetchCurrentUser({ commit }) {
      axios.get("/users/get_current_user").then((response) => {
        commit("loadCurrentUser", response.data);
      });
    },
    updateCurrentUserQuestionShareRight({ commit }) {
      axios
        .patch(`users/update_question_share_right`)
        .then((response) => {
          commit("updateCurrentUser", response.data);
        });
    },
    updateCurrentUserRankingShareRight({ commit }) {
      axios
        .patch(`users/update_ranking_share_right`)
        .then((response) => {
          commit("updateCurrentUser", response.data);
        });
    },
    updateCurrentUserYesOrNoShareRight({ commit }) {
      axios
        .patch(`users/update_yes_or_no_share_right`)
        .then((response) => {
          commit("updateCurrentUser", response.data);
        });
    },
    updateCurrentUserTextShareRight({ commit }) {
      axios
        .patch(`users/update_text_share_right`)
        .then((response) => {
          commit("updateCurrentUser", response.data);
        });
    },
  },
};
