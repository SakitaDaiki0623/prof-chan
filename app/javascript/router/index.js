// app/javascript/router/index.js
import Vue from "vue";
import VueRouter from "vue-router";
import store from "../store/index.js";
import ProfilesPage from "../pages/profile/index";
import ShowProfilesPage from "../pages/profile/show";
import NewProfilesPage from "../pages/profile/new";
import EditProfilesPage from "../pages/profile/edit";
import Top from "../pages/top.vue"
import NotFound from "../pages/shared/NotFound";

Vue.use(VueRouter);

const routes = [
  {
    path: "/top",
    name: "Top",
    component: Top,
  },
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
  {
    path: "/profiles/:id(\\d+)",
    name: "ShowProfilesPage",
    component: ShowProfilesPage,
    props: true,
  },
  {
    path: "/profiles/:id(\\d+)/edit",
    name: "EditProfilesPage",
    component: EditProfilesPage,
    props: true,
    beforeEnter: (to, from, next) => {
      if (store.state == undefined) return;
      const currentUserProfileId = store.state.users.currentUser.profile.id;
      if (currentUserProfileId == to.params.id) {
        next();
      } else {
        next({ path: `/profiles/${currentUserProfileId}/edit` });
        store.dispatch("flash/setFlash", {
          type: "error",
          message: "他の人のプロフは編集できないよ！",
          color: "red lighten-3",
        });
      }
    },
  },
  {
    name: "NotFound",
    path: "*",
    component: NotFound,
    meta: { title: "お探しのページは見つかりませんでした" },
  },
];

const router = new VueRouter({ mode: "history", routes });

export default router;
