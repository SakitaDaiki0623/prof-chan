<!-- app/javascript/components/TheHeader.vue -->
<template>
  <header v-show="doesCurrentUserhaveProfile">
    <v-app-bar color="brown lighten-2" outlined>
      <v-toolbar-title>
        <router-link to="/top"> プロフちゃん(ロゴ) </router-link>
      </v-toolbar-title>

      <div class="flex-grow-1" />

      <v-btn
        id="profile-edit-button"
        @click="openProfilesPage"
        class="m-2 white--text"
        color="brown lighten-2"
      >
        <v-icon left> mdi-account-group </v-icon>
        プロフ一覧
      </v-btn>

      <v-btn
        id="profile-edit-button"
        @click="openProfileEditPage"
        class="m-2 white--text"
        color="brown lighten-2"
      >
        <v-icon left> mdi-pencil </v-icon>
        プロフ編集
      </v-btn>

      <v-btn
        class="m-2 white--text"
        color="brown darken-1"
        href="/logout"
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
        .push(`/profiles/${this.currentUser.profile.id}/edit`)
        .catch((err) => {});
    },
  },
};
</script>

<style scoped>
</style>