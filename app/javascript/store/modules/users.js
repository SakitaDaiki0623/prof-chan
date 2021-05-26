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
    loadCurrentUser(state, currentUser) {
      state.currentUser = currentUser;
    },
  },
  actions: {
    fetchCurrentUser({ commit }) {
      axios.get("/users/get_current_user").then((response) => {
        commit("loadCurrentUser", response.data);
      });
    },
  },
};
