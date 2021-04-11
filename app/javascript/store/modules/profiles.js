// app/javascript/store/modules/profiles.js
import axios from "../../plugins/axios.js";

export const profiles = {
  namespaced: true,
  state: {
    profiles: [],
  },
  getters: {
    getProfiles: (state) => state.profiles,
  },
  mutations: {
    addProfile: (state, profile) => {
      state.profiles.push(profile);
    },
    loadProfiles(state, profiles) {
      state.profiles = profiles;
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
    fetchProfiles({ commit }) {
      axios
        .get("profiles")
        .then((response) => {
          commit("loadProfiles", response.data);
        })
        .catch((error) => console.log(error.status));
    },
  },
};
