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
    updateProfile(state, data) {
      // findIndex ・・・ 配列の中から条件を満たした要素のindex番号を返す
      const index = state.profiles.findIndex((profile) => {
        return profile.id == data.id;
      });
      state.profiles.splice(index, 1, data);
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
    patchProfile({ commit }, payload) {
      axios
        .patch(`profiles/${payload.id}`, payload)
        .then((response) => {
          commit("updateProfile", response.data);
        })
        .catch((err) => console.log(err));
    },
  },
};
