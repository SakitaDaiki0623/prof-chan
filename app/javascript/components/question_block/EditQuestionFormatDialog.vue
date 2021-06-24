<template>
  <v-dialog
    :value="isShownEditQuestionFormatDialog"
    max-width="1000"
    @click:outside="hundleCloseQuestionBlockEditDialog"
    @input="$emit('input', $event.target.isShownEditQuestionFormatDialog)"
  >
    <v-card :color="questionBlockColor">
      <v-row
        justify="end"
        class="mr-2 mt-2"
      >
        <v-btn
          :color="questionBlockColor"
          @click="hundleCloseQuestionBlockEditDialog"
        >
          <v-icon> mdi-close-outline </v-icon>
        </v-btn>
      </v-row>
      <p class="font-weight-bold text-white text-4xl text-center mt-10 mb-10">
        クエスチョンブロックを編集
      </p>

      <div class="pa-10 note-box">
        <v-row
          v-show="!isShownForm"
          align="center"
        >
          <v-col
            cols="12"
            md="10"
          >
            <p class="text-2xl font-bold pt-3">
              {{ editQuestionBlock.title }}
            </p>
          </v-col>
          <v-col
            cols="12"
            md="1"
          >
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
          <ValidationObserver
            ref="observer"
            v-slot="{ invalid }"
          >
            <form>
              <div>
                <label
                  class="form-label-text-block"
                  for="question_block_title"
                >タイトル</label>
                <ValidationProvider
                  v-slot="{ errors }"
                  name="タイトル"
                  rules="input_required|max:15"
                >
                  <input
                    :id="
                      'edit-question-title-form-' + editQuestionBlockForForm.id
                    "
                    :value="editQuestionBlockForForm.title"
                    class="input-form-question-block"
                    name="question_block[question_block_title]"
                    type="text"
                    @input="
                      editQuestionBlockForForm.title = $event.target.value
                    "
                  >
                  <span class="red--text text-sm">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>
              <v-row
                justify="end"
                align="center"
                class="pt-3"
              >
                <v-col
                  cols="12"
                  md="1"
                >
                  <v-btn
                    :id="
                      'update-question-item-button-' +
                        editQuestionBlockForForm.id
                    "
                    tile
                    small
                    color="red lighten-4"
                    :disabled="invalid"
                    @click="
                      hundleEditQuestionBlockTitle(editQuestionBlockForForm)
                    "
                  >
                    更新
                  </v-btn>
                </v-col>
                <v-col
                  cols="12"
                  md="1"
                >
                  <v-btn
                    :id="
                      'cancel-question-item-update-button-' +
                        editQuestionBlockForForm.id
                    "
                    tile
                    small
                    color="red darken-1"
                    @click="hideEditQuestionBlockTitleForm"
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
          question-block-item-id="edit-question-item-1"
          :question-item="questionItem1"
          :question-name-for-validation="questionNameForValidation1"
          :answer-name-for-validation="answerNameForValidation1"
          :question-item-length="questionItemLength"
          :is-the-item-editing="isTheFirstItemEditing"
          :question-block-color="questionBlockColor"
          @show-edit-question-item-form="showTheFirstEditQuestionItemForm"
          @hide-edit-question-item-form="hideTheFirstEditQuestionItemForm"
        />
        <EditQuestionBlockItem
          v-if="questionItemLength >= 2"
          question-block-item-id="edit-question-item-2"
          :question-item="questionItem2"
          :question-name-for-validation="questionNameForValidation2"
          :answer-name-for-validation="answerNameForValidation2"
          :is-the-item-editing="isTheSecondItemEditing"
          :question-item-length="questionItemLength"
          :question-block-color="questionBlockColor"
          @show-edit-question-item-form="showTheSecondEditQuestionItemForm"
          @hide-edit-question-item-form="hideTheSecondEditQuestionItemForm"
        />
        <EditQuestionBlockItem
          v-if="questionItemLength >= 3"
          question-block-item-id="edit-question-item-3"
          :question-item="questionItem3"
          :question-name-for-validation="questionNameForValidation3"
          :answer-name-for-validation="answerNameForValidation3"
          :is-the-item-editing="isTheThirdItemEditing"
          :question-item-length="questionItemLength"
          :question-block-color="questionBlockColor"
          @show-edit-question-item-form="showTheThirdEditQuestionItemForm"
          @hide-edit-question-item-form="hideTheThirdEditQuestionItemForm"
        />

        <IndividualCreateQuestionBlockItem
          v-if="questionItemLength < 3"
          ref="IndividualCreateQuestionBlockItem"
          :parent-question-block-id="parentQuestionBlockId"
        />

        <div class="mt-3 font-weight-bold text-sm">
          {{ certainlyPushUpdateButton }}
        </div>
        <div class="text-center mt-3">
          <v-btn
            id="creation_button"
            type="submit"
            depressed
            elevation="4"
            x-large
            :color="questionBlockColor"
            class="white--text"
            @click="hundleCloseQuestionBlockEditDialog"
          >
            編集をおしまいにする
          </v-btn>
        </div>
      </div>
    </v-card>
  </v-dialog>
</template>

<script>
import axios from "axios";
import { mapState, mapActions } from "vuex";

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
    questionBlockColor: {
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
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "クエスチョンブロックのタイトルを更新したよ！",
        color: this.questionBlockColor,
      });
    },

    addQuestionItemNum() {
      this.questionItemNum++;
    },
    deleteQuestionItemNum() {
      this.questionItemNum--;
    },

    closeEditQuestionFormatDialog() {
      this.$emit("close-question-block-format-dialog");
      this.hideAllEditQuestionItemForm();
    },

    // 元のアイテムの状態に戻す
    revertItemStateBeforeEdit() {
      this.$emit("close-question-block-edit-dialog", this.editQuestionBlock);
    },

    hundleCloseQuestionBlockEditDialog() {
      this.revertItemStateBeforeEdit();
      this.closeEditQuestionFormatDialog();

      if (this.questionItemLength < 3) {
        this.$refs.IndividualCreateQuestionBlockItem.resetQuestionItem();
      }
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

    hideAllEditQuestionItemForm() {
      this.hideEditQuestionBlockTitleForm();
      this.hideTheFirstEditQuestionItemForm();
      this.hideTheSecondEditQuestionItemForm();
      this.hideTheThirdEditQuestionItemForm();
    },
  },
};
</script>

<style scoped>
.note-box {
  background-color: #ffcdd2;
  background-image: radial-gradient(#ffffff 40%, transparent 20%),
    radial-gradient(#ffffff 20%, transparent 20%);
  background-size: 40px 40px;
  background-position: 0 0, 20px 20px;
}
</style>
