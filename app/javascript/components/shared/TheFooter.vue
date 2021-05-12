<template>
  <v-footer app absolute color="brown lighten-3">
    <v-spacer />
    <div>
      <v-btn dense text>利用規約</v-btn>
    </div>
    <small>&copy; {{ copyText }}</small>
  </v-footer>
</template>

<script>
export default {
  data() {
    return {
      startYear: 2021,
    };
  },
  computed: {
    thisYear() {
      return new Date().getFullYear();
    },
    copyText() {
      if (this.startYear === this.thisYear) {
        return `${this.thisYear} - プロフちゃん`;
      }
      return `${this.startYear} - ${this.thisYear} - プロフちゃん`;
    },
  },
};
</script>

<style lang="scss" scoped>
small {
  margin-left: 20px;
}
.v-btn:not(.v-btn--round).v-size--default {
  padding: 0 5px;
}
</style>
