<!-- app/javascript/components/TextFormatDialog.vue -->
<template>
  <div>
    <v-dialog
      :value="isShownEditQuestionFormatDialog"
      max-width="800"
      persistent
      @input="$emit('input', $event.target.isShownEditQuestionFormatDialog)"
    >
      <v-card color="red lighten-3">
        <v-row justify="end" class="mr-2 mt-2">
          <v-btn color="red lighten-3" @click="hundleCancelQuestionBlockUpdate">
            ✖︎
          </v-btn>
        </v-row>
        <p
          class="font-weight-bold font-prof-default text-white text-4xl text-center mt-10 mb-10"
        >
          クエスチョンブロックを編集
        </p>

        <div class="p-10 bg-question-prof-block bg-fixed">
          <v-row align="center" v-show="!isShownForm">
            <v-col cols="12" md="10">
              <p class="text-2xl font-bold text-gray-600 pt-3">
                {{ editQuestionBlock.title }}
              </p>
            </v-col>
            <v-col cols="12" md="1">
              <v-btn
                :id="'edit-question-block-title-button-' + editQuestionBlock.id"
                tile
                small
                color="red lighten-4"
                @click="showEditQuestionBlockTitleForm"
              >
                <v-icon> mdi-pencil </v-icon>
              </v-btn>
            </v-col>
          </v-row>

          <!-- タイトル編集フォーム -->
          <div v-show="isShownForm">
            <ValidationObserver ref="observer" v-slot="{ invalid }">
              <form>
                <div>
                  <label class="form-label-text-block" for="text_block_title"
                    >タイトル</label
                  >
                  <ValidationProvider
                    v-slot="{ errors }"
                    name="タイトル"
                    rules="input_required|max:30"
                  >
                    <input
                      id="text_block_title"
                      :value="editQuestionBlockForForm.title"
                      @input="
                        editQuestionBlockForForm.title = $event.target.value
                      "
                      class="input-form-text-block"
                      name="text_block[text_block_title]"
                      type="text"
                    />
                    <span class="text-red-400">{{ errors[0] }}</span>
                  </ValidationProvider>
                </div>
                <v-row justify="end" align="center" class="pt-3">
                  <v-col cols="12" md="1">
                    <v-btn
                      :id="
                        'update-question-item-button-' +
                        editQuestionBlockForForm.id
                      "
                      tile
                      small
                      color="red lighten-4"
                      :disabled="invalid"
                      class="font-prof-default"
                      @click="
                        hundleEditQuestionBlockTitle(editQuestionBlockForForm)
                      "
                    >
                      更新
                    </v-btn>
                  </v-col>
                  <v-col cols="12" md="1">
                    <v-btn
                      :id="
                        'cancel-question-item-update-button-' +
                        editQuestionBlockForForm.id
                      "
                      tile
                      small
                      color="red darken-1"
                      @click="hideEditQuestionBlockTitleForm"
                      class="font-prof-default"
                    >
                      ×
                    </v-btn>
                  </v-col>
                </v-row>
              </form>
            </ValidationObserver>
          </div>

          <!-- Item Form -->
          <EditQuestionBlockItem
            :questionItem="questionItem1"
            :questionNameForValidation="questionNameForValidation1"
            :answerNameForValidation="answerNameForValidation1"
            :questionItemLength="questionItemLength"
            :isTheItemEditing="isTheFirstItemEditing"
            @show-edit-question-item-form="showTheFirstEditQuestionItemForm"
            @hide-edit-question-item-form="hideTheFirstEditQuestionItemForm"
          />
          <EditQuestionBlockItem
            :questionItem="questionItem2"
            :questionNameForValidation="questionNameForValidation2"
            :answerNameForValidation="answerNameForValidation2"
            :isTheItemEditing="isTheSecondItemEditing"
            :questionItemLength="questionItemLength"
            v-if="questionItemLength >= 2"
            @show-edit-question-item-form="showTheSecondEditQuestionItemForm"
            @hide-edit-question-item-form="hideTheSecondEditQuestionItemForm"
          />
          <EditQuestionBlockItem
            :questionItem="questionItem3"
            :questionNameForValidation="questionNameForValidation3"
            :answerNameForValidation="answerNameForValidation3"
            :isTheItemEditing="isTheThirdItemEditing"
            :questionItemLength="questionItemLength"
            v-if="questionItemLength >= 3"
            @show-edit-question-item-form="showTheThirdEditQuestionItemForm"
            @hide-edit-question-item-form="hideTheThirdEditQuestionItemForm"
          />

          <IndividualCreateQuestionBlockItem
            :parentQuestionBlockId="parentQuestionBlockId"
            v-if="questionItemLength < 3"
          />

          <div
            class="mt-3 font-weight-bold font-prof-default text-gray-600 text-sm"
          >
            {{ certainlyPushUpdateButton }}
          </div>
          <div class="text-center mt-3">
            <v-btn
              id="creation_button"
              type="submit"
              depressed
              elevation="4"
              x-large
              color="red lighten-3"
              class="white--text"
              @click="hundleCancelQuestionBlockUpdate"
            >
              編集をおしまいにする
            </v-btn>
          </div>
        </div>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions } from "vuex";

// components ----------
import EditQuestionBlockItem from "../question_block/EditQuestionBlockItem";
import IndividualCreateQuestionBlockItem from "../question_block/IndividualCreateQuestionBlockItem";

export default {
  components: {
    EditQuestionBlockItem,
    IndividualCreateQuestionBlockItem,
  },
  props: {
    isShownEditQuestionFormatDialog: {
      type: Boolean,
      required: true,
    },
    editQuestionBlock: {
      type: Object,
      required: true,
    },
    textBlockColorForFlashMessage: {
      type: String,
      required: false,
    },
  },
  data() {
    return {
      questionNameForValidation1: "1番目の質問",
      answerNameForValidation1: "1番目の答え",
      questionNameForValidation2: "2番目の質問",
      answerNameForValidation2: "2番目の答え",
      questionNameForValidation3: "3番目の質問",
      answerNameForValidation3: "3番目の答え",
      certainlyPushUpdateButton: "※変更する時は必ず「更新」ボタンを押してね！",

      isShownForm: false,
      isTheFirstItemEditing: false,
      isTheSecondItemEditing: false,
      isTheThirdItemEditing: false,
    };
  },
  computed: {
    ...mapState("questionBlocks", ["questionBlocks"]),
    ...mapState("questionBlocks", ["questionItems"]),

    editQuestionBlockForForm() {
      return Object.assign({}, this.editQuestionBlock);
    },
    questionItemLength() {
      return this.questionItemsOfEditQuestionBlock.length;
    },
    additionalFormNum() {
      return 3 - this.questionItemLength;
    },
    questionItemsOfEditQuestionBlock() {
      return this.questionItems.filter(
        (questionItem) =>
          questionItem.question_block.id == this.editQuestionBlock.id
      );
    },
    questionItem1() {
      return (this.questionItemsOfEditQuestionBlock[0] = Object.assign(
        {},
        this.questionItemsOfEditQuestionBlock[0]
      ));
    },
    questionItem2() {
      if (this.questionItemsOfEditQuestionBlock[1] == undefined) return;
      return (this.questionItemsOfEditQuestionBlock[1] = Object.assign(
        {},
        this.questionItemsOfEditQuestionBlock[1]
      ));
    },
    questionItem3() {
      if (this.questionItemsOfEditQuestionBlock[2] == undefined) return;
      return (this.questionItemsOfEditQuestionBlock[2] = Object.assign(
        {},
        this.questionItemsOfEditQuestionBlock[2]
      ));
    },
    // 新規作成のために親であるクエスチョンアイテムブロックのidを渡すためのメソッド
    parentQuestionBlockId() {
      return this.editQuestionBlock.id;
    },
  },
  methods: {
    ...mapActions({
      patchQuestionBlock: "questionBlocks/patchQuestionBlock",
    }),
    hundleEditQuestionBlockTitle(editQuestionBlock) {
      if (editQuestionBlock.title == "") return;
      this.patchQuestionBlock(editQuestionBlock);
      this.editQuestionBlock.title = editQuestionBlock.title;
      this.hideEditQuestionBlockTitleForm();
    },

    addQuestionItemNum() {
      this.questionItemNum++;
    },
    deleteQuestionItemNum() {
      this.questionItemNum--;
    },

    hundleCloseEditQuestionFormatDialog() {
      this.$emit("close-question-block-format-dialog");
      this.hideEditQuestionBlockTitleForm();
    },

    hundleCancelQuestionBlockUpdate() {
      this.$emit("cancel-question-block-update", this.editQuestionBlock);
      this.hundleCloseEditQuestionFormatDialog();
      requestAnimationFrame(() => {
        this.$refs.observer.reset();
      });
    },
    showEditQuestionBlockTitleForm() {
      this.isShownForm = true;
    },
    hideEditQuestionBlockTitleForm() {
      this.isShownForm = false;
    },
    showTheFirstEditQuestionItemForm() {
      this.isTheFirstItemEditing = true;
    },
    hideTheFirstEditQuestionItemForm() {
      this.isTheFirstItemEditing = false;
    },
    showTheSecondEditQuestionItemForm() {
      this.isTheSecondItemEditing = true;
    },
    hideTheSecondEditQuestionItemForm() {
      this.isTheSecondItemEditing = false;
    },
    showTheThirdEditQuestionItemForm() {
      this.isTheThirdItemEditing = true;
    },
    hideTheThirdEditQuestionItemForm() {
      this.isTheThirdItemEditing = false;
    },
  },
};
</script>
