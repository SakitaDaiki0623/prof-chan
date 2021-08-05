import Vue from "vue";
import Vuex from "vuex";
import axios from "../plugins/axios.js";
// [参考]: https://qiita.com/_masa_u/items/b58b92c283f4e770e094
import createPersistedState from "vuex-persistedstate";

import { users } from "./modules/users";
import { flash } from "./modules/flash";
import { isNotFound } from "./modules/isNotFound";
import { activeHash } from "./modules/activeHash";

Vue.use(Vuex);
Vue.prototype.$axios = axios;

export default new Vuex.Store({
  modules: {
    users,
    flash,
    isNotFound,
    activeHash,
  },
  plugins: [
    createPersistedState({
      key: "profChan",
      storage: window.sessionStorage,
    }),
  ],
});
