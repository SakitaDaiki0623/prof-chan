<template>
  <div v-if="isProviderSlack && notSharedYet">
    <v-checkbox v-model="check" label="slackに投稿しますか?"></v-checkbox>
    <div class="text-gray-600 text-sm">※Slackへの投稿は1日に1回のみです。</div>
  </div>
</template>

<script>
export default {
  props: {
    isProviderSlack: {
      type: Boolean,
      required: true,
    },
    notSharedYet: {
      type: Boolean,
      required: true,
    },
    check: {
      type: Boolean,
      required: true,
      default: false,
    },
  },
};
</script>