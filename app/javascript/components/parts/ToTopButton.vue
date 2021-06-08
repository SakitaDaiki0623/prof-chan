<template>
  <transition>
    <div class="ma-16" v-show="visible">
      <v-row>
        <v-btn
          v-scroll-to="toTop"
          color="brown"
          x-large
          fab
          class="white--text"
          bottom
          fixed
          right
          ><v-icon>mdi-arrow-up</v-icon></v-btn
        >
      </v-row>
    </div>
  </transition>
</template>

<script>
export default {
  data() {
    return {
      toTop: "#top",
      visible: false,
    };
  },
  // 参考: https://zenn.dev/han_aru/articles/d0ffed8e1db18d
  created() {
    window.addEventListener("scroll", this.handleScroll);
  },
  methods: {
    handleScroll() {
      this.scrollY = window.scrollY;
      if (!this.visible) {
        this.visible = window.scrollY > 100;
      } else if (window.scrollY < 90) {
        this.visible = !this.visible;
      }
    },
  },
};
</script>

<style scoped>
.v-enter {
  opacity: 0;
}

.v-enter-active,
.v-leave-active {
  transition: opacity 0.2s;
}

.v-enter-to {
  opacity: 1;
}

.v-leave-to {
  opacity: 0;
  transition: opacity 0.2s;
}
</style>
