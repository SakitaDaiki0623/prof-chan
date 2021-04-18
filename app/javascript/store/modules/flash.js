const state = () => ({
  flash: {
    type: "",
    message: "",
    color: "",
  },
});

const getters = {
  flash: (state) => state.flash,
  isFlash: (state) => !!state.flash.message,
};

const mutations = {
  setFlash(state, { type, message, color }) {
    state.flash.type = type;
    state.flash.message = message;
    state.flash.color = color;
  },
};

const actions = {
  setFlash({ commit }, { type, message, color }) {
    commit("setFlash", { type, message, color });
  },
};

export const flash = {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
};
