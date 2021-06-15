<template>
  <div>
    <div class="fullview">
      <div class="loading-spacer" />
      <vue-loading
        type="spiningDubbles"
        color="#A1887F"
        :size="{ width: '100px', height: '100px' }"
      />
    </div>
  </div>
</template>

<script>
import { VueLoading } from "vue-loading-template";

export default {
  name: "Loading",
  components: {
    VueLoading,
  },

};
</script>

<style>
.fullview {
  width: 100%;
  height: 100%;
  background: #fffaf0;
  position: fixed;
  top: 0;
  left: 0;
}
.loading-spacer {
  height: 30%;
}
</style>
