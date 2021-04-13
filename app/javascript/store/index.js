import Vue from "vue";
import Vuex from "vuex";
import axios from "../plugins/axios.js";
import { profiles } from "./modules/profiles";
import { users } from "./modules/users";
import { textBlocks } from "./modules/textBlocks";
import { profileBlocks } from "./modules/profileBlocks";

Vue.use(Vuex);
Vue.prototype.$axios = axios;

export default new Vuex.Store({
  modules: {
    profiles,
    users,
    textBlocks,
    profileBlocks,
  },
});
