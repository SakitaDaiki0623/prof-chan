// app/javascript/store/modules/isNotFound.js
const state = () => ({
  isNotFound: false
})

const getters = {
  isNotFound: state => state.isNotFound
}

const mutations = {
  setIsNotFound(state, { boolean }) {
    state.isNotFound = boolean
  }
}

const actions = {
  setIsNotFound({ commit }, { boolean }) {
    commit("setIsNotFound", { boolean })
  }
}

export const isNotFound = {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
