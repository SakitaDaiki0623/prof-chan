<template>
  <v-app id="app">
    <TheHeader />
    <TheFlashMessage v-if="isFlash" />
    <router-view />
  </v-app>
</template>

<script>
import { mapGetters } from "vuex";
import TheHeader from "./components/shared/TheHeader";
import TheFlashMessage from "./components/shared/TheFlashMessage";

export default {
  components: { TheHeader, TheFlashMessage },
  data() {
    return {};
  },
  computed: {
    ...mapGetters({
      isFlash: "flash/isFlash",
    }),
  },
};
</script>

<style scoped></style>
