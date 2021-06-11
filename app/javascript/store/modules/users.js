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
    updateCurrentUserShareRight({ commit }, payload) {
      console.log(payload);
      axios.patch(`users/${payload.id}/update_share_right`, payload).then((response) => {
        commit("updateCurrentUser", response.data);
      });
    },
  },
};
