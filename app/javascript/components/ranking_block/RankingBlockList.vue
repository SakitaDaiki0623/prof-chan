<template>
  <v-container>
    <v-row>
      <v-col
        v-for="rankingBlock in myRankingBlocks"
        :key="rankingBlock.id"
        cols="12"
        sm="6"
      >
        <v-card
          class="bg-ranking-prof-block bg-cover shadow rounded-2xl p-5"
        >
          <v-row justify="end">
            <v-btn
              :id="'edit-ranking-block-button-' + rankingBlock.id"
              tile
              small
              color="green lighten-4"
              @click="openEditRankingFormatDialog(rankingBlock)"
            >
              <v-icon> mdi-pencil </v-icon>
            </v-btn>
            <v-btn
              :id="'delete-ranking-block-button-' + rankingBlock.id"
              tile
              small
              color="green lighten-1"
              @click="hundleDeleteRankingBlock(rankingBlock)"
            >
              <v-icon> mdi-delete </v-icon>
            </v-btn>
          </v-row>
          <p class="text-2xl font-bold text-gray-600 pt-3">
            {{ rankingBlock.title }}
          </p>
          <v-card class="p-5 rounded-lg" outlined>
            {{ rankingBlock.first_place }}
          </v-card>
          <v-card class="p-5 rounded-lg" outlined>
            {{ rankingBlock.second_place }}
          </v-card>
          <v-card class="p-5 rounded-lg" outlined>
            {{ rankingBlock.third_place }}
          </v-card>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    myRankingBlocks: {
      type: Array,
      required: true,
    },
  },
  methods: {
    openEditRankingFormatDialog(rankingBlock) {
      this.$emit("open-edit-ranking-format-dialog", rankingBlock);
    },
    hundleDeleteRankingBlock(rankingBlock) {
      this.$emit("delete-ranking-block", rankingBlock);
    },
  },
};
</script>