import Vue from "vue";
import Vuex from "vuex";
import axios from "../plugins/axios.js";
// [参考]: https://qiita.com/_masa_u/items/b58b92c283f4e770e094
import createPersistedState from "vuex-persistedstate";

import { users } from "./modules/users";
import { flash } from "./modules/flash";
import { isNotFound } from "./modules/isNotFound";

// Blocks
import { questionBlocks } from "./modules/questionBlocks";
import { profileBlocks } from "./modules/profileBlocks";
import { rankingBlocks } from "./modules/rankingBlocks";
import { yesOrNoBlocks } from "./modules/yesOrNoBlocks";

Vue.use(Vuex);
Vue.prototype.$axios = axios;

export default new Vuex.Store({
  modules: {
    users,
    flash,
    isNotFound,

    // Blocks
    profileBlocks,
    questionBlocks,
    rankingBlocks,
    yesOrNoBlocks,
  },
  plugins: [
    createPersistedState({
      // ストレージのキーを指定。デフォルトではvuex
      key: "profChan",

      // 管理対象のステートを指定。pathsを書かない時は`modules`に書いたモジュールに含まれるステート全て。`[]`の時はどれも保存されない
      // paths: ["auth.isLoggedIn", "master.dataSelected"],
      // paths: ["users.currentUser"],

      // ストレージの種類を指定する。デフォルトではローカルストレージ
      storage: window.sessionStorage,
    }),
  ],
});
