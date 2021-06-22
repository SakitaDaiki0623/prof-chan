<template>
  <v-dialog
    :value="isShownEditYesOrNoFormatDialog"
    max-width="800"
    @click:outside="hundleCloseYesOrNoBlockEditDialog"
    @input="$emit('input', $event.target.isShownEditYesOrNoFormatDialog)"
  >
    <v-card :color="yesOrNoBlockColor">
      <v-row
        justify="end"
        class="mr-2 mt-2"
      >
        <v-btn
          :color="yesOrNoBlockColor"
          @click="hundleCloseYesOrNoBlockEditDialog"
        >
          <v-icon> mdi-close-outline </v-icon>
        </v-btn>
      </v-row>
      <p class="font-weight-bold text-white text-4xl text-center mt-10 mb-10">
        Yes or No ブロックを編集
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
              {{ editYesOrNoBlock.title }}
            </p>
          </v-col>
          <v-col
            cols="12"
            md="1"
          >
            <v-btn
              :id="'edit-yes-or-no-block-title-button-' + editYesOrNoBlock.id"
              tile
              small
              color="orange lighten-4"
              @click="showEditYesOrNoBlockTitleForm"
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
                  for="yes_or_no_block_title"
                >タイトル</label>
                <ValidationProvider
                  v-slot="{ errors }"
                  name="タイトル"
                  rules="input_required|max:50"
                >
                  <input
                    :id="
                      'edit-yes-or-no-title-form-' + editYesOrNoBlockForForm.id
                    "
                    :value="editYesOrNoBlockForForm.title"
                    class="input-form-yes-or-no-block"
                    name="yes_or_no_block[yes_or_no_block_title]"
                    type="text"
                    @input="editYesOrNoBlockForForm.title = $event.target.value"
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
                      'update-yes-or-no-item-button-' +
                        editYesOrNoBlockForForm.id
                    "
                    tile
                    small
                    color="orange lighten-4"
                    :disabled="invalid"
                    @click="
                      hundleEditYesOrNoBlockTitle(editYesOrNoBlockForForm)
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
                      'cancel-yes-or-no-item-update-button-' +
                        editYesOrNoBlockForForm.id
                    "
                    tile
                    small
                    color="orange darken-1"
                    @click="hideEditYesOrNoBlockTitleForm"
                  >
                    ×
                  </v-btn>
                </v-col>
              </v-row>
            </form>
          </ValidationObserver>
        </div>

        <!-- Item Form -->
        <EditYesOrNoBlockItem
          yes-or-no-block-item-id="edit-yes-or-no-item-1"
          :yes-or-no-item="yesOrNoItem1"
          :yes-or-no-name-for-validation="yesOrNoNameForValidation1"
          :answer-name-for-validation="answerNameForValidation1"
          :yes-or-no-item-length="yesOrNoItemLength"
          :is-the-item-editing="isTheFirstItemEditing"
          :yes-or-no-block-color="yesOrNoBlockColor"
          @show-edit-yes-or-no-item-form="showTheFirstEditYesOrNoItemForm"
          @hide-edit-yes-or-no-item-form="hideTheFirstEditYesOrNoItemForm"
        />
        <EditYesOrNoBlockItem
          v-if="yesOrNoItemLength >= 2"
          yes-or-no-block-item-id="edit-yes-or-no-item-2"
          :yes-or-no-item="yesOrNoItem2"
          :yes-or-no-name-for-validation="yesOrNoNameForValidation2"
          :answer-name-for-validation="answerNameForValidation2"
          :is-the-item-editing="isTheSecondItemEditing"
          :yes-or-no-item-length="yesOrNoItemLength"
          :yes-or-no-block-color="yesOrNoBlockColor"
          @show-edit-yes-or-no-item-form="showTheSecondEditYesOrNoItemForm"
          @hide-edit-yes-or-no-item-form="hideTheSecondEditYesOrNoItemForm"
        />
        <EditYesOrNoBlockItem
          v-if="yesOrNoItemLength >= 3"
          yes-or-no-block-item-id="edit-yes-or-no-item-3"
          :yes-or-no-item="yesOrNoItem3"
          :yes-or-no-name-for-validation="yesOrNoNameForValidation3"
          :answer-name-for-validation="answerNameForValidation3"
          :is-the-item-editing="isTheThirdItemEditing"
          :yes-or-no-item-length="yesOrNoItemLength"
          :yes-or-no-block-color="yesOrNoBlockColor"
          @show-edit-yes-or-no-item-form="showTheThirdEditYesOrNoItemForm"
          @hide-edit-yes-or-no-item-form="hideTheThirdEditYesOrNoItemForm"
        />

        <IndividualCreateYesOrNoBlockItem
          v-if="yesOrNoItemLength < 3"
          ref="IndividualCreateYesOrNoBlockItem"
          :parent-yes-or-no-block-id="parentYesOrNoBlockId"
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
            :color="yesOrNoBlockColor"
            class="white--text"
            @click="hundleCloseYesOrNoBlockEditDialog"
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

import EditYesOrNoBlockItem from "../yes_or_no_block/EditYesOrNoBlockItem";
import IndividualCreateYesOrNoBlockItem from "../yes_or_no_block/IndividualCreateYesOrNoBlockItem";

export default {
  components: {
    EditYesOrNoBlockItem,
    IndividualCreateYesOrNoBlockItem,
  },
  props: {
    isShownEditYesOrNoFormatDialog: {
      type: Boolean,
      required: true,
    },
    editYesOrNoBlock: {
      type: Object,
      required: true,
    },
    yesOrNoBlockColor: {
      type: String,
      required: false,
    },
  },
  data() {
    return {
      yesOrNoNameForValidation1: "1番目の質問",
      answerNameForValidation1: "1番目の答え",
      yesOrNoNameForValidation2: "2番目の質問",
      answerNameForValidation2: "2番目の答え",
      yesOrNoNameForValidation3: "3番目の質問",
      answerNameForValidation3: "3番目の答え",
      certainlyPushUpdateButton: "※変更する時は必ず「更新」ボタンを押してね！",

      isShownForm: false,
      isTheFirstItemEditing: false,
      isTheSecondItemEditing: false,
      isTheThirdItemEditing: false,
    };
  },
  computed: {
    ...mapState("yesOrNoBlocks", ["yesOrNoBlocks"]),
    ...mapState("yesOrNoBlocks", ["yesOrNoItems"]),

    editYesOrNoBlockForForm() {
      return Object.assign({}, this.editYesOrNoBlock);
    },
    yesOrNoItemLength() {
      return this.yesOrNoItemsOfEditYesOrNoBlock.length;
    },
    additionalFormNum() {
      return 3 - this.yesOrNoItemLength;
    },
    yesOrNoItemsOfEditYesOrNoBlock() {
      return this.yesOrNoItems.filter(
        (yesOrNoItem) =>
          yesOrNoItem.yes_or_no_block.id == this.editYesOrNoBlock.id
      );
    },
    yesOrNoItem1() {
      return (this.yesOrNoItemsOfEditYesOrNoBlock[0] = Object.assign(
        {},
        this.yesOrNoItemsOfEditYesOrNoBlock[0]
      ));
    },
    yesOrNoItem2() {
      if (this.yesOrNoItemsOfEditYesOrNoBlock[1] == undefined) return;
      return (this.yesOrNoItemsOfEditYesOrNoBlock[1] = Object.assign(
        {},
        this.yesOrNoItemsOfEditYesOrNoBlock[1]
      ));
    },
    yesOrNoItem3() {
      if (this.yesOrNoItemsOfEditYesOrNoBlock[2] == undefined) return;
      return (this.yesOrNoItemsOfEditYesOrNoBlock[2] = Object.assign(
        {},
        this.yesOrNoItemsOfEditYesOrNoBlock[2]
      ));
    },
    // 新規作成のために親であるYes or No アイテムブロックのidを渡すためのメソッド
    parentYesOrNoBlockId() {
      return this.editYesOrNoBlock.id;
    },
  },
  methods: {
    ...mapActions({
      patchYesOrNoBlock: "yesOrNoBlocks/patchYesOrNoBlock",
    }),
    hundleEditYesOrNoBlockTitle(editYesOrNoBlock) {
      if (editYesOrNoBlock.title == "") return;
      this.patchYesOrNoBlock(editYesOrNoBlock);
      this.editYesOrNoBlock.title = editYesOrNoBlock.title;
      this.hideEditYesOrNoBlockTitleForm();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "Yes or No ブロックのタイトルを更新したよ！",
        color: this.YesOrNoBlockColor,
      });
    },

    addYesOrNoItemNum() {
      this.yesOrNoItemNum++;
    },
    deleteYesOrNoItemNum() {
      this.yesOrNoItemNum--;
    },

    closeEditYesOrNoFormatDialog() {
      this.$emit("close-yes-or-no-block-format-dialog");
      this.hideAllEditYesOrNoItemForm();
    },

    revertItemStateBeforeEdit() {
      this.$emit("close-yes-or-no-block-edit-dialog", this.editYesOrNoBlock);
    },

    hundleCloseYesOrNoBlockEditDialog() {
      this.revertItemStateBeforeEdit();
      this.closeEditYesOrNoFormatDialog();

      if (this.yesOrNoItemLength < 3) {
        this.$refs.IndividualCreateYesOrNoBlockItem.resetYesOrNoItem();
      }
      requestAnimationFrame(() => {
        this.$refs.observer.reset();
      });
    },

    showEditYesOrNoBlockTitleForm() {
      this.isShownForm = true;
    },
    hideEditYesOrNoBlockTitleForm() {
      this.isShownForm = false;
    },
    showTheFirstEditYesOrNoItemForm() {
      this.isTheFirstItemEditing = true;
    },
    hideTheFirstEditYesOrNoItemForm() {
      this.isTheFirstItemEditing = false;
    },
    showTheSecondEditYesOrNoItemForm() {
      this.isTheSecondItemEditing = true;
    },
    hideTheSecondEditYesOrNoItemForm() {
      this.isTheSecondItemEditing = false;
    },
    showTheThirdEditYesOrNoItemForm() {
      this.isTheThirdItemEditing = true;
    },
    hideTheThirdEditYesOrNoItemForm() {
      this.isTheThirdItemEditing = false;
    },

    hideAllEditYesOrNoItemForm() {
      this.hideEditYesOrNoBlockTitleForm();
      this.hideTheFirstEditYesOrNoItemForm();
      this.hideTheSecondEditYesOrNoItemForm();
      this.hideTheThirdEditYesOrNoItemForm();
    },
  },
};
</script>

<style scoped>
.note-box {
  position: relative;
  background-color: #ffe0b2;
}
.note-box::before {
  content: "";
  position: absolute;
  border-right: dashed 5px rgb(155, 155, 155); /*ドットの大きさ、高さ*/
  height: 90%;
  top: 0.5em;
  left: 0.5em;
}

.note-box::after {
  content: "";
  position: absolute;
  border-right: dashed 5px rgb(155, 155, 155); /*ドットの大きさ、高さ*/
  height: 50%;
  top: 3em;
  right: 0.5em;
}
</style>
