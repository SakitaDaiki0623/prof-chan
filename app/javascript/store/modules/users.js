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
      axios
        .get("/users/new")
        .then((response) => {
          commit("loadCurrentUser", response.data);
        })
        .catch((err) => console.log(err.status));
    },
    fetchUsers({ commit }) {
      axios
        .get("users")
        .then((response) => {
          commit("loadUsers", response.data);
        })
        .catch((err) => console.log(err.status));
    },
  },
};
