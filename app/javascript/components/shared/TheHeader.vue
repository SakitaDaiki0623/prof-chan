<!-- app/javascript/components/TheHeader.vue -->
<template>
  <header>
    <v-app-bar
      v-show="doesCurrentUserhaveProfile"
      class="bg-header"
    >
      <v-toolbar-title>
        <router-link to="/profiles"> プロフちゃん(ロゴ) </router-link>
      </v-toolbar-title>

      <div class="flex-grow-1" />

      <v-btn
        id="profile-edit-button"
        @click="openProfileEditPage"
        class="m-2 white--text"
        color="blue-grey darken-2"
      >
        <v-icon left> mdi-pencil </v-icon>
        プロフ編集
      </v-btn>

      <a href="/logout" data-method="delete">ログアウト</a>
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
    openProfileEditPage() {
      this.$router
        .push(`/profiles/${this.currentUser.profile.id}/edit`)
        .catch((err) => {});
    },
  },
};
</script>

<style scoped>
.bg-header {
  background-image: linear-gradient(
    -45deg,
    #bfffa8 25%,
    #fbffcc 25%,
    #fbffcc 50%,
    #bfffa8 50%,
    #bfffa8 75%,
    #fbffcc 75%,
    #fbffcc
  );
}
</style>