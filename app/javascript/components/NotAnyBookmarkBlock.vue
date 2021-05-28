<template>
  <v-container>
    <v-row
      justify="center"
      align-content="center"
      class="p-20"
    >
      <v-col cols="12" sm="12" align="center">
        <div class="balloon1 text-4xl">
          {{ profMessage }}
        </div>
      </v-col>
      <v-col cols="12" sm="12">
        <img src="../images/prof_normal.png" class="image mx-auto" />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    profMessage: {
      type: String,
      required: false,
      default: "ブックマークボタンを押したブロックはまだないよ",
    },
  },
  computed: {
    isMobile() {
      return this.$vuetify.breakpoint.xsOnly;
    },
  },
};
</script>
<style scoped>
.image {
  max-width: 20rem;
}
</style>
