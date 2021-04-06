// app/javascript/router/index.js
import Vue from "vue";
import VueRouter from "vue-router";
import NewProfilesPage from "../pages/profile/new";

Vue.use(VueRouter);

const routes = [
  {
    path: "/profiles/new",
    name: "new_profile",
    component: NewProfilesPage,
  },
];

const router = new VueRouter({ mode: "history", routes });

export default router;
