// app/javascript/store/modules/users.js
import axios from "../../plugins/axios.js";

export const users = {
  namespaced: true,
  state: {
    users: [],
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
      axios
        .get("/users/new")
        .then((response) => {
          commit("loadCurrentUser", response.data);
        })
        .catch((err) => console.log(err.status));
    },
  },
};
