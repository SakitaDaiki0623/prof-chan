import Vue from "vue";
import Vuex from "vuex";
import axios from "../plugins/axios.js";
import { profiles } from "./modules/profiles";
import { users } from "./modules/users";

Vue.use(Vuex);
Vue.prototype.$axios = axios;

export default new Vuex.Store({
  modules: {
    profiles,
    users,
  },
});
