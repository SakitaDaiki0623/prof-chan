<template>
  <div :id="questionBlockItemId" class="ma-1">
    <!-- Item Form -->
    <v-row v-show="!isTheItemEditing" align="center" justify="center">
      <v-col cols="12" md="10">
        <v-row>
          <v-col cols="12" sm="6">
            {{ questionItem.content }}
          </v-col>
          <v-col cols="12" sm="12" class="text-red-500">
            <v-card class="pa-5 rounded-lg" outlined>
              {{ questionItem.answer }}
            </v-card>
          </v-col>
        </v-row>
      </v-col>

      <v-col cols="12" md="1">
        <v-btn
          :id="'edit-question-item-button-' + questionItem.id"
          tile
          small
          color="red lighten-4"
          @click="showEditQuestionItemForm"
        >
          <v-icon> mdi-pencil </v-icon>
        </v-btn>
      </v-col>
      <v-col cols="12" md="1">
        <v-btn
          :id="'delete-question-item-button-' + questionItem.id"
          tile
          small
          color="red lighten-1"
          :disabled="IsItemLengthOne"
          @click="hundleDeleteQuestionItem(questionItem)"
        >
          <v-icon> mdi-delete </v-icon>
        </v-btn>
      </v-col>
    </v-row>

    <!-- Item Form -->
    <div v-show="isTheItemEditing">
      <ValidationObserver ref="observer" v-slot="{ invalid }">
        <form>
          <v-row>
            <v-col cols="12" md="6">
              <label for="question_item_content" class="form-label-text-block"
                >質問</label
              >
              <ValidationProvider
                v-slot="{ errors }"
                :name="questionNameForValidation"
                rules="input_required|max:20"
              >
                <input
                  :id="'edit-question-item-content-form-' + editQuestionItem.id"
                  :value="editQuestionItem.content"
                  class="input-form-question-block"
                  name="question_item[question_item_content]"
                  type="text"
                  @input="editQuestionItem.content = $event.target.value"
                />
                <span class="red--text text-sm">{{ errors[0] }}</span>
              </ValidationProvider>
            </v-col>
            <v-col cols="12" md="6">
              <label for="question_item_content" class="form-label-text-block"
                >答え</label
              >
              <ValidationProvider
                v-slot="{ errors }"
                :name="answerNameForValidation"
                rules="input_required|max:20"
              >
                <input
                  :id="'edit-question-item-answer-form-' + editQuestionItem.id"
                  :value="editQuestionItem.answer"
                  class="input-form-question-block"
                  name="question_item[question_item_answer]"
                  type="text"
                  @input="editQuestionItem.answer = $event.target.value"
                />
                <span class="red--text text-sm">{{ errors[0] }}</span>
              </ValidationProvider>
            </v-col>
          </v-row>
          <v-row justify="end">
            <v-col cols="12" md="1">
              <v-btn
                :id="'update-question-item-button-' + editQuestionItem.id"
                tile
                small
                color="red lighten-4"
                :disabled="invalid"
                @click="hundleUpdateQuestionItem(editQuestionItem)"
              >
                更新
              </v-btn>
            </v-col>
            <v-col cols="12" md="1">
              <v-btn
                :id="
                  'cancel-question-item-update-button-' + editQuestionItem.id
                "
                tile
                small
                color="red darken-1"
                @click="cancelEditQuestionItem"
              >
                ×
              </v-btn>
            </v-col>
          </v-row>
        </form>
      </ValidationObserver>
    </div>
  </div>
</template>

<script>
import axios from "axios";
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
    questionItemLength: {
      type: Number,
      require: false,
    },
    isTheItemEditing: {
      type: Boolean,
      require: false,
    },
    questionBlockItemId: {
      type: String,
      require: true,
    },
    questionBlockColor: {
      type: String,
      require: true,
    },
  },
  data() {
    return {};
  },
  computed: {
    editQuestionItem: {
      get() {
        return Object.assign({}, this.questionItem);
      },
      set(newValue) {
        const content = newValue.content;
        const answer = newValue.answer;
        this.content = content;
        this.answer = answer;
      },
    },
    IsItemLengthOne() {
      return this.questionItemLength == 1 ? true : false;
    },
  },
  methods: {
    showEditQuestionItemForm() {
      this.$emit("show-edit-question-item-form");
    },
    hideEditQuestionItemForm() {
      this.$emit("hide-edit-question-item-form");
    },

    cancelEditQuestionItem() {
      this.hideEditQuestionItemForm();
      requestAnimationFrame(() => {
        this.$refs.observer.reset();
      });
    },

    hundleUpdateQuestionItem(questionItem) {
      this.patchQuestionItem(questionItem);
      this.editQuestionItem = questionItem;
      this.hideEditQuestionItemForm();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "クエスチョンアイテムを更新したよ！",
        color: this.questionBlockColor,
      });
    },

    patchQuestionItem(questionItem) {
      axios
        .patch(`/api/v1/question_items/${questionItem.id}`, questionItem)
        .then((response) => {
          this.$emit("update-question-item", response.data);
        });
    },

    hundleDeleteQuestionItem(questionItem) {
      this.deleteQuestionItem(questionItem);
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "クエスチョンアイテムを削除したよ！",
        color: this.questionBlockColor,
      });
    },

    deleteQuestionItem(questionItem) {
      axios
        .delete(`/api/v1/question_items/${questionItem.id}`, questionItem)
        .then((response) => {
          this.$emit("retrieve-question-item", response.data);
        });
    },
  },
};
</script>
