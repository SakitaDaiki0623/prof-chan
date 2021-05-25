<!-- app/javascript/components/TheHeader.vue -->
<template>
  <header v-show="doesCurrentUserhaveProfile">
    <v-app-bar color="brown lighten-2" outlined height="80px">
      <v-toolbar-title>
        <router-link to="/top">
          <img src="../../images/prof_normal.png" class="logo" />
        </router-link>
      </v-toolbar-title>

      <v-btn
        id="profile-edit-button"
        class="m-2 white--text"
        color="brown lighten-2"
        @click="openProfileEditPage"
      >
        <v-icon left>
          mdi-pencil
        </v-icon>
        プロフ編集
      </v-btn>

      <v-menu right bottom>
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            v-bind="attrs"
            v-on="on"
            color="brown lighten-3"
            class="white--text"
          >
            <v-icon>mdi-dots-horizontal</v-icon>プロフ関連
          </v-btn>
        </template>

        <v-list color="brown lighten-3">
          <v-list-item
            v-for="item in itemLists"
            :key="item.id"
            @click="item.clickEvent"
          >
            <v-list-item-avatar color="white">
              <v-icon>{{ item.icon }}</v-icon>
            </v-list-item-avatar>
            <v-list-item-title class="white--text">{{
              item.text
            }}</v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>

      <v-btn
        id="profile-edit-button"
        class="m-2 white--text"
        color="brown lighten-2"
        @click="openAboutPage"
      >
        <v-icon left>
          mdi-information-outline
        </v-icon>
        プロフちゃんとは
      </v-btn>

      <v-spacer />

      <v-btn
        class="m-2 white--text"
        color="brown darken-1"
        href="/users/sign_out"
        data-method="delete"
      >
        ログアウト
      </v-btn>
    </v-app-bar>
  </header>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";

export default {
  data() {
    return {
      user: {},
      itemLists: [
        {
          id: 1,
          text: "プロフ一覧",
          icon: "mdi-account-group",
          clickEvent: this.openProfilesPage,
        },
        {
          id: 2,
          text: "人気のプロフブロック",
          icon: "mdi-crown-outline",
          clickEvent: this.openPopularBlocksPage,
        },
        {
          id: 3,
          text: "ブックマーク",
          icon: "mdi-account-star-outline",
          clickEvent: this.openBookmarkPage,
        },
      ],
    };
  },
  computed: {
    ...mapState("users", ["currentUser"]),
    doesCurrentUserhaveProfile() {
      if (this.currentUser.profile === null) {
        return false;
      } else {
        return true;
      }
    },
  },
  created() {},
  methods: {
    openProfilesPage() {
      this.$router.push(`/profiles`).catch((err) => {});
    },
    openProfileEditPage() {
      this.$router
        .push(`/profiles/${this.currentUser.profile.public_uid}/edit`)
        .catch((err) => {});
    },
    openPopularBlocksPage() {
      this.$router.push("/popular_blocks").catch((err) => {});
    },
    openBookmarkPage() {
      this.$router.push("/bookmark_page").catch((err) => {});
    },
    openRecommendedUsers() {
      this.$router.push("/recommended_users").catch((err) => {});
    },
    openAboutPage() {
      this.$router.push("/about").catch((err) => {});
    },
  },
};
</script>

<style scoped>
.logo {
  max-width: 4rem;
  background: white;
  border-radius: 50px;
}
</style>
