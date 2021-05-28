<template>
  <!-- Item Form -->
  <div
    :id="questionBlockItemId"
    class="ma-1"
  >
    <v-row>
      <v-col
        cols="12"
        md="6"
      >
        <label
          for="question_item_content"
          class="form-label-text-block"
        >質問</label>
        <ValidationProvider
          v-slot="{ errors }"
          :name="questionNameForValidation"
          rules="input_required|max:50"
        >
          <input
            :value="questionItem.content"
            class="input-form-question-block"
            name="question_item[question_item_content]"
            type="text"
            @input="questionItem.content = $event.target.value"
          >
          <span class="red--text">{{ errors[0] }}</span>
        </ValidationProvider>
      </v-col>
      <v-col
        cols="12"
        md="6"
      >
        <label
          for="question_item_answer"
          class="form-label-text-block"
        >答え</label>
        <ValidationProvider
          v-slot="{ errors }"
          :name="answerNameForValidation"
          rules="input_required|max:50"
        >
          <input
            :value="questionItem.answer"
            class="input-form-question-block"
            name="question_item[question_item_answer]"
            type="text"
            @input="questionItem.answer = $event.target.value"
          >
          <span class="red--text">{{ errors[0] }}</span>
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
