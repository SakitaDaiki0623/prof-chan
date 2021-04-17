<template>
  <v-app id="app">
    <TheHeader />
    <router-view />
  </v-app>
</template>

<script>
import TheHeader from "./components/shared/TheHeader";

export default {
  components: { TheHeader },
  data: function() {
    return {};
  },
};
</script>

<style scoped></style>
