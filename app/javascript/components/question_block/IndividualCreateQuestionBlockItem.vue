<template>
  <!-- Item Form -->
  <ValidationObserver ref="observer" v-slot="{ invalid }">
    <form>
      <div class="m-1">
        <v-row>
          <v-col cols="12" md="6">
            <label for="question_item_content" class="form-label-question-block"
              >質問</label
            >
            <ValidationProvider
              v-slot="{ errors }"
              name="質問"
              rules="input_required|max:50"
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
              rules="input_required|max:50"
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
        <v-row justify="end">
          <v-col cols="12" md="2">
            <v-btn
              tile
              large
              color="red lighten-4"
              :disabled="invalid"
              class="font-prof-default	"
              @click="hundleCreateIndevisialQuestionItem(questionItem)"
            >
              作成！
            </v-btn>
          </v-col>
        </v-row>
      </div>
    </form>
  </ValidationObserver>
</template>

<script>
import { mapState, mapActions } from "vuex";

export default {
  props: {
    parentQuestionBlockId: {
      type: Number,
      required: true,
    },
  },
  data() {
    return {
      questionItem: {
        content: "",
        answer: "",
        question_block_id: this.parentQuestionBlockId,
      },
    };
  },
  methods: {
    ...mapActions({
      createQuestionItem: "questionBlocks/createQuestionItem",
    }),

    hundleCreateIndevisialQuestionItem(questionItem) {
      this.createQuestionItem(questionItem);
      this.resetQuestionItem();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "クエスチョンアイテムを作成したよ！",
        color: "red lighten-3",
      });
    },
    resetQuestionItem() {
      this.questionItem.content = "";
      this.questionItem.answer = "";
      requestAnimationFrame(() => {
        this.$refs.observer.reset();
      });
    },
  },
};
</script>
