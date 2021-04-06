// app/javascript/router/index.js
import Vue from "vue";
import VueRouter from "vue-router";
import ProfilesPage from "../pages/profile/index";
import NewProfilesPage from "../pages/profile/new";

Vue.use(VueRouter);

const routes = [
  {
    path: "/profiles/new",
    name: "NewProfilesPage",
    component: NewProfilesPage,
  },
  {
    path: "/profiles",
    name: "ProfilesPage",
    component: ProfilesPage,
  },
];

const router = new VueRouter({ mode: "history", routes });

export default router;
