<template>
  <div>
    <v-card color="brown lighten-2" outlined>
      <div>
        <v-row justify="center" align-content="center">
          <v-img
            class="ring-4 rounded-full ring-gray-600 text-center sample_box2_3"
            :src="user.image.url"
            max-height="250px"
            max-width="250px"
          />
        </v-row>
      </div>
    </v-card>
    <v-card color="brown lighten-5 text-center" outlined>
      <div
        class="p-3 text-4xl font-bold text-gray-600 border-dotted	border-b-2 border-gray-400"
      >
        <span class="name-text">{{ user.name }}</span
        >さん
      </div>
    </v-card>
  </div>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      required: true,
    },
    isThisEditPage: {
      type: Boolean,
      required: true,
    },
  },
};
</script>

<style scoped>
.sample_box2_3 {
  padding: 1em 1.5em;
  margin: 2em 0;
  background-color: #ffc6c6; /*背景色*/
  box-shadow: 0 0 0 8px #ffc6c6; /*背景色外側*/
  border: 2px dashed #ffffff; /*線*/
  color: #000000; /*文字色*/
}
</style>
