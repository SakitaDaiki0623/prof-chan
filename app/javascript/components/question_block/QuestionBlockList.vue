<template>
  <v-container>
    <v-row>
      <v-col
        v-for="questionBlock in myQuestionBlocks"
        :key="questionBlock.id"
        cols="12"
        sm="6"
      >
        <v-card class="bg-question-prof-block bg-cover shadow rounded-2xl p-5">
          <v-row justify="end">
            <v-btn
              :id="'edit-question-block-button-' + questionBlock.id"
              tile
              small
              color="red lighten-4"
              @click="openEditQuestionFormatDialog(questionBlock)"
            >
              <v-icon> mdi-pencil </v-icon>
            </v-btn>
            <v-btn
              :id="'delete-question-block-button-' + questionBlock.id"
              tile
              small
              color="red lighten-1"
              @click="hundleDeleteQuestionBlock(questionBlock)"
            >
              <v-icon> mdi-delete </v-icon>
            </v-btn>
          </v-row>
          <p class="text-2xl font-bold text-gray-600 pt-3">
            {{ questionBlock.title }}
          </p>
          <template v-for="question_item in questionBlock.question_items">
            <div :key="question_item.id">
              <v-card class="p-5 rounded-lg" outlined>
                <v-row>
                  <v-col cols="12" sm="4">
                    {{ question_item.content }}
                  </v-col>
                  <v-col cols="12" sm="8" class="text-red-500">
                    {{ question_item.answer }}
                  </v-col>
                </v-row>
              </v-card>
            </div>
          </template>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapState, mapActions } from "vuex";

export default {
  computed: {
    ...mapState("questionBlocks", ["questionBlocks"]),
    ...mapState("users", ["currentUser"]),

    myQuestionBlocks() {
      return (
        this.questionBlocks.filter(
          (questionBlock) =>
            questionBlock.profile_block.id == this.currentUser.profile_block.id
        ) || {}
      );
    },
  },
  methods: {
    openEditQuestionFormatDialog(questionBlock) {
      this.$emit("open-question-text-format-dialog", questionBlock);
    },
    hundleDeleteQuestionBlock(questionBlock) {
      this.$emit("delete-question-block", questionBlock);
    },
  },
};
</script>
