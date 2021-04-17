<!-- app/javascript/components/TheHeader.vue -->
<template>
  <v-app-bar
    v-show="doesCurrentUserhaveProfile"
    class="font-prof-default"
    color="gray accent-4"
    dark
  >
    <v-app-bar-nav-icon />

    <v-toolbar-title>
      <router-link to="/profiles">
        プロフちゃん
      </router-link>
    </v-toolbar-title>

    <div class="flex-grow-1" />
    <a href="/logout" data-method="delete">ログアウト</a>

    <v-btn icon>
      <v-icon>mdi-magnify</v-icon>
    </v-btn>

    <v-btn id="profile-edit-button" icon @click="openProfileEditPage">
      <v-icon>mdi-pencil</v-icon>
    </v-btn>

    <v-menu left bottom>
      <template #activator="{ on }">
        <v-btn icon v-on="on">
          <v-icon>mdi-dots-vertical</v-icon>
        </v-btn>
      </template>

      <v-list>
        <v-list-item v-for="n in 1" :key="n" @click="() => {}">
          <v-list-item-title />
        </v-list-item>
      </v-list>
    </v-menu>
  </v-app-bar>
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
