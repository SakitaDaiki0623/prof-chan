<template>
  <!-- Item Form -->
  <div class="m-1" :id="questionBlockItemId">
    <v-row>
      <v-col cols="12" md="6">
        <label for="question_item_content" class="form-label-question-block"
          >質問</label
        >
        <ValidationProvider
          v-slot="{ errors }"
          :name="questionNameForValidation"
          rules="input_required|max:50"
        >
          <input
            :value="questionItem.content"
            @input="questionItem.content = $event.target.value"
            class="input-form-question-block"
            name="question_item[question_item_content]"
            type="text"
          />
          <span class="text-red-400">{{ errors[0] }}</span>
        </ValidationProvider>
      </v-col>
      <v-col cols="12" md="6">
        <label for="question_item_answer" class="form-label-question-block"
          >答え</label
        >
        <ValidationProvider
          v-slot="{ errors }"
          :name="answerNameForValidation"
          rules="input_required|max:50"
        >
          <input
            :value="questionItem.answer"
            @input="questionItem.answer = $event.target.value"
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
    questionNameForValidation: {
      type: String,
      require: true,
    },
    answerNameForValidation: {
      type: String,
      require: true,
    },
    questionBlockItemId: {
      type: String,
      require: true,
    },
  },
};
</script>
