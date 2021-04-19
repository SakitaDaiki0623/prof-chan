<template>
  <!-- Item Form -->
  <div class="m-1">
    <v-row>
      <v-col cols="12" md="6">
        <label for="question_item_content" class="form-label-question-block"
          >質問</label
        >
        <ValidationProvider
          v-slot="{ errors }"
          name="質問"
          rules="input_required|max:30"
        >
          <input
            v-model="questionItem.content"
            class="input-form-question-block"
            name="question_item[question_item_content]"
            type="text"
          />
          <span class="text-red-400">{{ errors[0] }}</span>
        </ValidationProvider>
      </v-col>
      <v-col cols="12" md="6">
        <label for="question_item_content" class="form-label-question-block"
          >答え</label
        >
        <ValidationProvider
          v-slot="{ errors }"
          name="答え"
          rules="input_required|max:30"
        >
          <input
            v-model="questionItem.answer"
            class="input-form-question-block"
            name="question_item[question_item_answer]"
            type="text"
          />
          <span class="text-red-400">{{ errors[0] }}</span>
        </ValidationProvider>
      </v-col>
    </v-row>
  </div>
</template>

<script>
export default {
  props: {
    questionItem: {
      type: Object,
      require: true,
    },
  },
};
</script>