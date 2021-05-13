// app/javascript/store/modules/profileBlocks.js
import axios from "../../plugins/axios.js";

export const profileBlocks = {
  namespaced: true,
  state: {
    profileBlocks: [],
  },
  mutations: {
    loadProfileBlocks(state, profileBlocks) {
      state.profileBlocks = profileBlocks;
    },
  },
  actions: {
    fetchProfileBlocks({ commit }) {
      axios
        .get("profile_blocks")
        .then((response) => {
          commit("loadProfileBlocks", response.data);
        })
    },
  },
};
