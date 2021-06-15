<!-- app/javascript/app.vue -->
<template>
  <v-app
    id="app"
    class="default kawaii"
  >
    <TheHeader />
    <Loading v-show="loading" />
    <v-main v-show="!loading">
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
import Loading from "./components/shared/Loading";
import TheFlashMessage from "./components/shared/TheFlashMessage";
import TheNotFound from "./pages/shared/NotFound";

export default {
  components: { TheHeader, TheFlashMessage, TheNotFound, TheFooter, Loading },
  data() {
    return {
      loading: true,
    };
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
  mounted() {
    setTimeout(() => {
      this.loading = false;
    }, 1000);
  },
};
</script>

<style scoped>
.default {
  font-family: "prof-font", "Hannotate SC Regular", "sans-serif";
  color: #381c1c;
}
.v-main {
  background-color: #fffaf0;
}
</style>
