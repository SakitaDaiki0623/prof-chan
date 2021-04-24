<!-- app/javascript/components/TextFormatDialog.vue -->
<template>
  <div>
    <v-dialog
      :value="isShownEditYesOrNoFormatDialog"
      max-width="800"
      persistent
      @input="$emit('input', $event.target.isShownEditYesOrNoFormatDialog)"
    >
      <v-card :color="yesOrNoBlockColor">
        <v-row justify="end" class="mr-2 mt-2">
          <v-btn
            :color="yesOrNoBlockColor"
            @click="hundleCloseYesOrNoBlockEditDialog"
          >
            ✖︎
          </v-btn>
        </v-row>
        <p class="font-weight-bold text-white text-4xl text-center mt-10 mb-10">
          クエスチョンブロックを編集
        </p>

        <div class="p-10 bg-yes-or-no-prof-block bg-fixed">
          <v-row align="center" v-show="!isShownForm">
            <v-col cols="12" md="10">
              <p class="text-2xl font-bold text-gray-600 pt-3">
                {{ editYesOrNoBlock.title }}
              </p>
            </v-col>
            <v-col cols="12" md="1">
              <v-btn
                :id="'edit-yes-or-no-block-title-button-' + editYesOrNoBlock.id"
                tile
                small
                color="red lighten-4"
                @click="showEditYesOrNoBlockTitleForm"
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
                  <label
                    class="form-label-yes-or-no-block"
                    for="yes_or_no_block_title"
                    >タイトル</label
                  >
                  <ValidationProvider
                    v-slot="{ errors }"
                    name="タイトル"
                    rules="input_required|max:50"
                  >
                    <input
                      :id="
                        'edit-yes-or-no-title-form-' +
                        editYesOrNoBlockForForm.id
                      "
                      :value="editYesOrNoBlockForForm.title"
                      @input="
                        editYesOrNoBlockForForm.title = $event.target.value
                      "
                      class="input-form-yes-or-no-block"
                      name="yes_or_no_block[yes_or_no_block_title]"
                      type="text"
                    />
                    <span class="text-red-400">{{ errors[0] }}</span>
                  </ValidationProvider>
                </div>
                <v-row justify="end" align="center" class="pt-3">
                  <v-col cols="12" md="1">
                    <v-btn
                      :id="
                        'update-yes-or-no-item-button-' +
                        editYesOrNoBlockForForm.id
                      "
                      tile
                      small
                      color="red lighten-4"
                      :disabled="invalid"
                      @click="
                        hundleEditYesOrNoBlockTitle(editYesOrNoBlockForForm)
                      "
                    >
                      更新
                    </v-btn>
                  </v-col>
                  <v-col cols="12" md="1">
                    <v-btn
                      :id="
                        'cancel-yes-or-no-item-update-button-' +
                        editYesOrNoBlockForForm.id
                      "
                      tile
                      small
                      color="red darken-1"
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
            yesOrNoBlockItemId="edit-yes-or-no-item-1"
            :yesOrNoItem="yesOrNoItem1"
            :yesOrNoNameForValidation="yesOrNoNameForValidation1"
            :answerNameForValidation="answerNameForValidation1"
            :yesOrNoItemLength="yesOrNoItemLength"
            :isTheItemEditing="isTheFirstItemEditing"
            :yes-or-no-block-color="yesOrNoBlockColor"
            @show-edit-yes-or-no-item-form="showTheFirstEditYesOrNoItemForm"
            @hide-edit-yes-or-no-item-form="hideTheFirstEditYesOrNoItemForm"
          />
          <EditYesOrNoBlockItem
            yesOrNoBlockItemId="edit-yes-or-no-item-2"
            :yesOrNoItem="yesOrNoItem2"
            :yesOrNoNameForValidation="yesOrNoNameForValidation2"
            :answerNameForValidation="answerNameForValidation2"
            :isTheItemEditing="isTheSecondItemEditing"
            :yesOrNoItemLength="yesOrNoItemLength"
            :yes-or-no-block-color="yesOrNoBlockColor"
            v-if="yesOrNoItemLength >= 2"
            @show-edit-yes-or-no-item-form="showTheSecondEditYesOrNoItemForm"
            @hide-edit-yes-or-no-item-form="hideTheSecondEditYesOrNoItemForm"
          />
          <EditYesOrNoBlockItem
            yesOrNoBlockItemId="edit-yes-or-no-item-3"
            :yesOrNoItem="yesOrNoItem3"
            :yesOrNoNameForValidation="yesOrNoNameForValidation3"
            :answerNameForValidation="answerNameForValidation3"
            :isTheItemEditing="isTheThirdItemEditing"
            :yesOrNoItemLength="yesOrNoItemLength"
            :yes-or-no-block-color="yesOrNoBlockColor"
            v-if="yesOrNoItemLength >= 3"
            @show-edit-yes-or-no-item-form="showTheThirdEditYesOrNoItemForm"
            @hide-edit-yes-or-no-item-form="hideTheThirdEditYesOrNoItemForm"
          />

          <IndividualCreateYesOrNoBlockItem
            :parentYesOrNoBlockId="parentYesOrNoBlockId"
            v-if="yesOrNoItemLength < 3"
            ref="IndividualCreateYesOrNoBlockItem"
          />

          <div class="mt-3 font-weight-bold text-gray-600 text-sm">
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
  </div>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions } from "vuex";

// components ----------
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
    // 新規作成のために親であるクエスチョンアイテムブロックのidを渡すためのメソッド
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
        message: "クエスチョンブロックのタイトルを更新したよ！",
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

    // 元のアイテムの状態に戻す
    revertItemStateBeforeEdit() {
      this.$emit("close-yes-or-no-block-edit-dialog", this.editYesOrNoBlock);
    },

    hundleCloseYesOrNoBlockEditDialog() {
      this.revertItemStateBeforeEdit();
      this.closeEditYesOrNoFormatDialog();

      if (this.yesOrNoItemLength < 3) {
        // 子コンポーネントのメソッドの呼び出し
        this.$refs.IndividualCreateYesOrNoBlockItem.resetYesOrNoItem();
      }
      requestAnimationFrame(() => {
        this.$refs.observer.reset();
      });
    },

    // FORMごとの表示・非表示の切り替え
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

    // 全てのフォームの表示をオフにする
    hideAllEditYesOrNoItemForm() {
      this.hideEditYesOrNoBlockTitleForm();
      this.hideTheFirstEditYesOrNoItemForm();
      this.hideTheSecondEditYesOrNoItemForm();
      this.hideTheThirdEditYesOrNoItemForm();
    },
  },
};
</script>
