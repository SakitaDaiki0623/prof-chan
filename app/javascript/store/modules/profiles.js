// app/javascript/store/modules/profiles.js
import axios from "../../plugins/axios.js";

export const profiles = {
  namespaced: true,
  state: {
    profiles: [],
  },
  getters: {
    profiles: (state) => state.profiles,
  },
  mutations: {
    addProfile: (state, profile) => {
      state.profiles.push(profile);
    },
  },
  actions: {
    createBasicProfile({ commit }, profile) {
      axios
        .post("profiles", profile)
        .then((response) => {
          commit("addProfile", response.data);
        })
        .catch((err) => console.log(err.status));
    },
  },
};
