<template>
  <v-container>
    <v-row>
      <v-col
        v-for="textBlock in myTextBlocks"
        :key="textBlock.id"
        cols="12"
        sm="4"
      >
        <v-card
          class="bg-text-prof-block bg-cover shadow rounded-2xl p-5"
          height="320"
          width="500"
        >
          <v-row justify="end">
            <v-btn
              :id="'edit-text-block-button-' + textBlock.id"
              tile
              small
              color="teal lighten-4"
              @click="openEditTextFormatDialog(textBlock)"
            >
              <v-icon> mdi-pencil </v-icon>
            </v-btn>
            <v-btn
              :id="'delete-text-block-button-' + textBlock.id"
              tile
              small
              color="teal lighten-1"
              @click="hundleDeleteTextBlock(textBlock)"
            >
              <v-icon> mdi-delete </v-icon>
            </v-btn>
          </v-row>
          <p class="text-2xl font-bold text-gray-600 pt-3">
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
  methods: {
    openEditTextFormatDialog(textBlock) {
      this.$emit("open-edit-text-format-dialog", textBlock);
    },
    hundleDeleteTextBlock(textBlock) {
      this.$emit("delete-text-block", textBlock);
    },
  },
};
</script>