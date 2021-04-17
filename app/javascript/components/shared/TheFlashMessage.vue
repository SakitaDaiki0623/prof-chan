<template>
  <v-fade-transition>
    <div class="flash font-prof-default">
      <v-alert
        dense
        outlined
        border="left"
        :color="flash.color"
        :type="flash.type"
      >
        {{ flash.message }}
      </v-alert>
    </div>
  </v-fade-transition>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  data() {
    return {
      isShow: true,
    };
  },
  computed: {
    ...mapGetters({ flash: "flash/flash" }),
  },
  mounted() {
    setTimeout(() => {
      this.$store.dispatch("flash/setFlash", {
        type: "",
        message: "",
        color: "",
      });
    }, 3000);
  },
};
</script>

<style scoped>
.flash {
  position: fixed;
  top: 10px;
  left: 20px;
  max-width: 350px;
  z-index: 100;
}
.v-alert--outlined {
  background: rgba(255, 255, 255, 0.9) !important;
}
.v-alert {
  font-size: 14px;
  font: bold;
}
</style>
