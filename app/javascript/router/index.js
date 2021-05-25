// app/javascript/router/index.js
import Vue from "vue";
import VueRouter from "vue-router";
import store from "../store/index.js";
import ProfilesPage from "../pages/profile/index";
import ShowProfilesPage from "../pages/profile/show";
import NewProfilesPage from "../pages/profile/new";
import EditProfilesPage from "../pages/profile/edit";
import Top from "../pages/top.vue";
import popularBlocks from "../pages/popularBlocks.vue";
import bookmarkPage from "../pages/bookmarkPage.vue";
import NotFound from "../pages/shared/NotFound";
import About from "../pages/static/about";

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
    path: "/profiles/:id",
    name: "ShowProfilesPage",
    component: ShowProfilesPage,
    props: true,
  },
  {
    path: "/profiles/:id/edit",
    name: "EditProfilesPage",
    component: EditProfilesPage,
    props: true,
    beforeEnter: (to, from, next) => {
      if (store.state == undefined) return;
      const currentUserProfileId =
        store.state.users.currentUser.profile.public_uid;
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
    path: "/popular_blocks",
    name: "popularBlocks",
    component: popularBlocks,
  },
  {
    path: "/bookmark_page",
    name: "bookmarkPage",
    component: bookmarkPage,
  },
  {
    path: "/about",
    name: "About",
    component: About,
  },
  {
    name: "NotFound",
    path: "*",
    component: NotFound,
    meta: { title: "お探しのページは見つかりませんでした" },
  },
];

const router = new VueRouter({
  mode: "history",
  routes,
  scrollBehavior(to, from, savedPosition) {
    return { x: 0, y: 0 }; // トップに移動
  },
});

export default router;
