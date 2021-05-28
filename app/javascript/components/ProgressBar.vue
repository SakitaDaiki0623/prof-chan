<template>
  <div>
    <v-progress-linear
      :value="percentageForBlocks"
      height="10"
      striped
      :color="blockColor"
    >
    </v-progress-linear>
    <div v-if="percentageForBlocks <= 40">
      <span class="text-lg blue--text text-center p-5 bg-white rounded-full"
        >充実度{{ percentageForBlocks }}%</span
      >
      <img src="../images/prof_sad.png" class="image" />
    </div>
    <div v-else-if="41 <= percentageForBlocks && percentageForBlocks <= 90">
      <span class="text-lg text-center p-5 bg-white rounded-full"
        >充実度{{ percentageForBlocks }}%</span
      >
      <img src="../images/prof_normal.png" class="image" />
    </div>
    <div v-else>
      <span class="text-lg red--text text-center p-5 bg-white rounded-full"
        >充実度{{ percentageForBlocks }}%</span
      >
      <img src="../images/prof_happy.png" class="image" />
    </div>
  </div>
</template>

<script>
export default {
  props: {
    percentageForBlocks: {
      type: Number,
      required: true,
    },
    blockColor: {
      type: String,
      required: true,
    },
  },
};
</script>

<style scoped>
.image {
  max-width: 5rem;
  display: inline;
}
</style>
