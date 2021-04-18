<template>
  <v-app id="app">
    <TheHeader />
    <v-main>
      <TheNotFound v-if="isNotFound" />
      <TheFlashMessage v-if="isFlash" />
      <router-view />
    </v-main>
    <TheFooter />
  </v-app>
</template>

<script>
import { mapGetters } from "vuex";
import TheHeader from "./components/shared/TheHeader";
import TheFooter from "./components/shared/TheFooter";
import TheFlashMessage from "./components/shared/TheFlashMessage";
import TheNotFound from "./pages/shared/NotFound";

export default {
  components: { TheHeader, TheFlashMessage, TheNotFound, TheFooter },
  data() {
    return {};
  },
  computed: {
    ...mapGetters({
      isFlash: "flash/isFlash",
      isNotFound: "isNotFound/isNotFound",
    }),
  },
  watch: {
    $route() {
      this.$store.dispatch("isNotFound/setIsNotFound", {
        boolean: false,
      });
    },
  },
};
</script>

<style scoped></style>
