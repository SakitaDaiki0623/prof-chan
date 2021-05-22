<template>
  <v-container class="no-block-display-container">
    <v-row justify="center">
      <div class="font-bold text-2xl opacity-50">
        社員の{{blockName}}ブロックがありません
      </div>
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    blockName: {
      type: String,
      required: true,
    },
  },
};
</script>
