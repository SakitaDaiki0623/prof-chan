import Vue from "vue";
import App from "../app.vue";
import store from "../store/index.js";
import router from "../router/index.js";

Vue.config.productionTip = false;

import axios from "../plugins/axios";
Vue.prototype.$axios = axios;

import Vuetify from 'vuetify'
import "vuetify/dist/vuetify.min.css"
Vue.use(Vuetify)
const vuetify = new Vuetify();

const VueScrollTo = require('vue-scrollto');
Vue.use(VueScrollTo)

import veeValidate from "../plugins/vee-validate"
Vue.mixin(veeValidate)

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    router,
    store,
    vuetify,
    render: (h) => h(App),
  }).$mount();
  document.body.appendChild(app.$el);
});

