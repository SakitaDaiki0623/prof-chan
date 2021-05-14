// app/javascript/store/modules/users.js
import axios from "../../plugins/axios.js";

export const users = {
  namespaced: true,
  state: {
    users: [],
    currentUser: {},
  },
  getters: {
    users: (state) => state.users,
    currentUser: (state) => state.currentUser,
  },
  mutations: {
    loadCurrentUser(state, currentUser) {
      state.currentUser = currentUser;
    },
    loadUsers(state, users) {
      state.users = users;
    },
  },
  actions: {
    fetchCurrentUser({ commit }) {
      axios.get("/users/get_current_user").then((response) => {
        commit("loadCurrentUser", response.data);
      });
    },
    fetchUsers({ commit }) {
      axios.get("users").then((response) => {
        commit("loadUsers", response.data);
      });
    },
  },
};
