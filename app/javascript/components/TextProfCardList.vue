<template>
  <v-container>
    <v-row>
      <v-col
        cols="12"
        sm="4"
        v-for="textBlock in myTextBlocks"
        :key="textBlock.id"
      >
        <v-card class="bg-text-prof-block bg-cover shadow rounded-2xl p-10" height="320" width="500">
          <p class="text-4xl font-bold text-gray-600">
            {{ textBlock.title }}
          </p>
          <v-card height="200" class="p-5 rounded-lg" outlined>
          {{ textBlock.text }}
          </v-card>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    myTextBlocks: {
      type: Array,
      required: true,
    },
  },
};
</script>