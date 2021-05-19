<template>
  <v-fade-transition>
    <div class="flash">
      <v-alert dense outlined border="left" :color="flash.color">
        <div v-if="flash.type == 'success'">
          <img src="../../images/prof_happy.png" class="w-10 inline-block"/>
          {{ flash.message }}
        </div>
        <div v-if="flash.type == 'error'">
          <img src="../../images/prof_sad.png" class="w-10 inline-block"/>
          {{ flash.message }}
        </div>
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
  max-width: 600px;
  z-index: 500;
}
.v-alert--outlined {
  background: rgba(255, 255, 255, 0.9) !important;
}
.v-alert {
  font-size: 14px;
  font: bold;
}
</style>
