<template>
  <!-- Item Form -->
  <div class="m-1" :id="yesOrNoBlockItemId">
    <v-row>
      <v-col cols="12" md="6">
        <label for="yes_or_no_item_content" class="form-label-yes-or-no-block"
          >質問</label
        >
        <ValidationProvider
          v-slot="{ errors }"
          :name="yesOrNoNameForValidation"
          rules="input_required|max:50"
        >
          <input
            :value="yesOrNoItem.content"
            @input="yesOrNoItem.content = $event.target.value"
            class="input-form-yes-or-no-block"
            name="yes_or_no_item[yes_or_no_item_content]"
            type="text"
          />
          <span class="text-red-400">{{ errors[0] }}</span>
        </ValidationProvider>
      </v-col>
      <v-col cols="12" md="6">
        <label
          for="yes_or_no_item_answer"
          class="form-label-yes-or-no-block inline-block"
        >
          答え
        </label>
        <v-radio-group v-model="yesOrNoItem.answer" mandatory row>
          <v-radio
            label="YES"
            :value="true"
            color="orange"
            class="yes-for-rspec"
          >
          </v-radio>
          <v-radio
            label="NO"
            :value="false"
            color="orange"
            class="no-for-rspec"
          ></v-radio>
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
