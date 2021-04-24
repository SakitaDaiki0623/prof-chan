<template>
  <div class="m-1" :id="questionBlockItemId">
    <!-- Item Form -->
    <v-row align="center" justify="center" v-show="!isTheItemEditing">
      <v-col cols="12" md="10">
        <v-card class="p-5 rounded-lg" outlined>
          <v-row>
            <v-col cols="12" sm="6">
              {{ questionItem.content }}
            </v-col>
            <v-col cols="12" sm="6" class="text-red-500">
              {{ questionItem.answer }}
            </v-col>
          </v-row>
        </v-card>
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
              <label
                for="question_item_content"
                class="form-label-question-block"
                >質問</label
              >
              <ValidationProvider
                v-slot="{ errors }"
                :name="questionNameForValidation"
                rules="input_required|max:50"
              >
                <input
                  :id="'edit-question-item-content-form-' + editQuestionItem.id"
                  :value="editQuestionItem.content"
                  @input="editQuestionItem.content = $event.target.value"
                  class="input-form-question-block"
                  name="question_item[question_item_content]"
                  type="text"
                />
                <span class="text-red-400">{{ errors[0] }}</span>
              </ValidationProvider>
            </v-col>
            <v-col cols="12" md="6">
              <label
                for="question_item_content"
                class="form-label-question-block"
                >答え</label
              >
              <ValidationProvider
                v-slot="{ errors }"
                :name="answerNameForValidation"
                rules="input_required|max:50"
              >
                <input
                  :id="'edit-question-item-answer-form-' + editQuestionItem.id"
                  :value="editQuestionItem.answer"
                  @input="editQuestionItem.answer = $event.target.value"
                  class="input-form-question-block"
                  name="question_item[question_item_answer]"
                  type="text"
                />
                <span class="text-red-400">{{ errors[0] }}</span>
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
                class="font-prof-default"
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
                class="font-prof-default"
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
import { mapState, mapActions } from "vuex";

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
    ...mapActions({
      patchQuestionItem: "questionBlocks/patchQuestionItem",
      deleteQuestionItem: "questionBlocks/deleteQuestionItem",
    }),
    showEditQuestionItemForm() {
      this.$emit("show-edit-question-item-form");
    },
    hideEditQuestionItemForm() {
      this.$emit("hide-edit-question-item-form");
    },

    // TODO: [FIX] 編集前の値に戻るように修正
    cancelEditQuestionItem() {
      this.hideEditQuestionItemForm();
      requestAnimationFrame(() => {
        this.$refs.observer.reset();
      });
    },

    // 更新
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

    // 削除
    hundleDeleteQuestionItem(questionItem) {
      if (!confirm("削除してよろしいですか?")) return;
      this.deleteQuestionItem(questionItem);
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "クエスチョンアイテムを削除したよ！",
        color: this.questionBlockColor,
      });
    },
  },
};
</script>
