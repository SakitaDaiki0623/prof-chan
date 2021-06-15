<template>
  <!-- Item Form -->
  <div
    :id="yesOrNoBlockItemId"
    class="ma-1"
  >
    <v-row>
      <v-col
        cols="12"
        sm="6"
      >
        <label
          for="yes_or_no_item_content"
          class="form-label-text-block"
        >質問</label>
        <ValidationProvider
          v-slot="{ errors }"
          :name="yesOrNoNameForValidation"
          rules="input_required|max:50"
        >
          <input
            :value="yesOrNoItem.content"
            class="input-form-yes-or-no-block"
            name="yes_or_no_item[yes_or_no_item_content]"
            type="text"
            @input="yesOrNoItem.content = $event.target.value"
          >
          <span class="red--text">{{ errors[0] }}</span>
        </ValidationProvider>
      </v-col>
      <v-col
        cols="12"
        sm="6"
      >
        <label
          for="yes_or_no_item_answer"
          class="form-label-text-block inline-block"
        >
          答え
        </label>
        <v-radio-group
          v-model="yesOrNoItem.answer"
          mandatory
          row
        >
          <v-radio
            label="YES"
            :value="true"
            color="orange"
            class="yes-for-rspec"
          />
          <v-radio
            label="NO"
            :value="false"
            color="orange"
            class="no-for-rspec"
          />
        </v-radio-group>
      </v-col>
    </v-row>
  </div>
</template>

<script>
export default {
  props: {
    yesOrNoItem: {
      type: Object,
      require: true,
      content: {
        type: String,
        require: false,
      },
      answer: {
        type: Boolean,
        require: false,
        default: true,
      },
    },
    yesOrNoNameForValidation: {
      type: String,
      require: true,
    },
    answerNameForValidation: {
      type: String,
      require: true,
    },
    yesOrNoBlockItemId: {
      type: String,
      require: true,
    },
  },
};
</script>
