<!-- app/javascript/components/TheHeader.vue -->
<template>
  <v-app-bar
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
    <a
      href="/logout"
      data-method="delete"
    >ログアウト</a>

    <v-btn icon>
      <v-icon>mdi-magnify</v-icon>
    </v-btn>

    <v-btn
      icon
      @click="openProfileEditPage"
    >
      <v-icon>mdi-pencil</v-icon>
    </v-btn>

    <v-menu
      left
      bottom
    >
      <template #activator="{ on }">
        <v-btn
          icon
          v-on="on"
        >
          <v-icon>mdi-dots-vertical</v-icon>
        </v-btn>
      </template>

      <v-list>
        <v-list-item
          v-for="n in 1"
          :key="n"
          @click="() => {}"
        >
          <v-list-item-title />
        </v-list-item>
      </v-list>
    </v-menu>
  </v-app-bar>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      user: {},
    };
  },
  computed: {},
  created() {
    // [TODO: リファクタリング] axiosのモジュールに移すか考える
    this.$axios
      .get("/users/new")
      .then((response) => (this.user = response.data))
      .catch((err) => console.log(err.status));
  },
  methods: {
    openProfileEditPage() {
      this.$router.push(`/profiles/${this.user.profile.id}/edit`);
    },
  },
};
</script>
