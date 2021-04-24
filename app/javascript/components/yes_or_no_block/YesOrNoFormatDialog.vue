<!-- app/javascript/components/yes_or_no_block/YesOrNoFormatDialog.vue -->
<template>
  <div>
    <v-dialog
      :value="isShownYesOrNoFormatDialog"
      max-width="800"
      persistent
      @input="$emit('input', $event.target.isShownYesOrNoFormatDialog)"
    >
      <v-card :color="yesOrNoBlockColor">
        <v-row justify="end" class="mr-2 mt-2">
          <v-btn
            :color="yesOrNoBlockColor"
            @click="hundleCloseYesOrNoFormatDialog"
          >
            ✖︎
          </v-btn>
        </v-row>
        <p
          class="font-weight-bold text-white text-4xl text-center mt-10"
        >
          Yes or No ブロック
        </p>

        <div
          id="yes-or-no-block-form"
          class="p-10 bg-yes-or-no-prof-block bg-fixed"
        >
          <div class="pb-2">
            <v-btn
              id="add-yes-or-no-item-button"
              type="submit"
              depressed
              elevation="4"
              small
              tile
              color="orange lighten-2"
              class="white--text"
              :disabled="yesOrNoItemNum >= 3"
              @click="addYesOrNoItemNum"
            >
              <v-icon left> mdi-plus </v-icon>
              質問と答えを追加する
            </v-btn>
            <v-btn
              id="delete-yes-or-no-item-button"
              type="submit"
              depressed
              elevation="4"
              small
              tile
              color="grey darken-3"
              class="white--text"
              :disabled="yesOrNoItemNum <= 1"
              @click="deleteYesOrNoItemNum"
            >
              <v-icon left> mdi-minus </v-icon>
              質問と答えを減らす
            </v-btn>
          </div>
          <ValidationObserver ref="observer" v-slot="{ invalid }">
            <form
              @submit.prevent="
                hundleCreateYesOrNoBlock(
                  yesOrNoBlock,
                  yesOrNoItem1,
                  yesOrNoItem2,
                  yesOrNoItem3
                )
              "
            >
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
                    id="yes_or_no_block_title"
                    v-model="yesOrNoBlock.title"
                    class="input-form-yes-or-no-block"
                    name="yes_or_no_block[yes_or_no_block_title]"
                    type="text"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>

              <!-- Item Form -->
              <YesOrNoBlockItem
                yesOrNoBlockItemId="create-yes-or-no-item-1"
                :yesOrNoItem="yesOrNoItem1"
                :yesOrNoNameForValidation="yesOrNoNameForValidation1"
                :answerNameForValidation="answerNameForValidation1"
              />
              <YesOrNoBlockItem
                yesOrNoBlockItemId="create-yes-or-no-item-2"
                :yesOrNoItem="yesOrNoItem2"
                v-if="yesOrNoItemNum >= 2"
                :yesOrNoNameForValidation="yesOrNoNameForValidation2"
                :answerNameForValidation="answerNameForValidation2"
              />
              <YesOrNoBlockItem
                yesOrNoBlockItemId="create-yes-or-no-item-3"
                :yesOrNoItem="yesOrNoItem3"
                v-if="yesOrNoItemNum >= 3"
                :yesOrNoNameForValidation="yesOrNoNameForValidation3"
                :answerNameForValidation="answerNameForValidation3"
              />

              <div class="text-center p-10">
                <v-btn
                  id="creation_button"
                  type="submit"
                  depressed
                  elevation="4"
                  x-large
                  :disabled="invalid"
                  :color="yesOrNoBlockColor"
                  class="white--text"
                >
                  <v-icon left> mdi-plus </v-icon>
                  Yes or No ブロックを作成！
                </v-btn>
              </div>
            </form>
          </ValidationObserver>
        </div>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
// plugins
import axios from "axios";
import { mapActions, mapState } from "vuex";

// components ----------
import YesOrNoBlockItem from "./YesOrNoBlockItem";

export default {
  components: {
    YesOrNoBlockItem,
  },
  props: {
    isShownYesOrNoFormatDialog: {
      type: Boolean,
      required: true,
    },
    yesOrNoBlockColor: {
      type: String,
      required: false,
    },
  },
  data() {
    return {
      yesOrNoBlock: {
        title: "",
      },
      yesOrNoItemNum: 1, // アイテム数
      yesOrNoItem1: {
        content: "",
        answer: "",
      },
      yesOrNoItem2: {
        content: "",
        answer: "",
      },
      yesOrNoItem3: {
        content: "",
        answer: "",
      },

      // Validator
      yesOrNoNameForValidation1: "1番目の質問",
      answerNameForValidation1: "1番目の答え",
      yesOrNoNameForValidation2: "2番目の質問",
      answerNameForValidation2: "2番目の答え",
      yesOrNoNameForValidation3: "3番目の質問",
      answerNameForValidation3: "3番目の答え",
    };
  },
  computed: {
    ...mapState({
      currentUser: "users/currentUser",
    }),
  },
  methods: {
    ...mapActions({
      createYesOrNoBlock: "yesOrNoBlocks/createYesOrNoBlock",
    }),
    addYesOrNoItemNum() {
      this.yesOrNoItemNum++;
    },
    deleteYesOrNoItemNum() {
      this.yesOrNoItemNum--;
      if (this.yesOrNoItemNum == 2) {
        this.yesOrNoItem3 = {};
      } else if (this.yesOrNoItemNum == 1) {
        this.yesOrNoItem2 = {};
      }
    },
    hundleCreateYesOrNoBlock(
      yesOrNoBlock,
      yesOrNoItem1,
      yesOrNoItem2,
      yesOrNoItem3
    ) {
      this.createYesOrNoBlock({
        yesOrNoBlock: yesOrNoBlock,
        yesOrNoItem1: yesOrNoItem1,
        yesOrNoItem2: yesOrNoItem2,
        yesOrNoItem3: yesOrNoItem3,
      });
      this.hundleCloseYesOrNoFormatDialog();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "Yes or No ブロックを作成したよ！",
        color: this.yesOrNoBlockColor,
      });
    },
    hundleCloseYesOrNoFormatDialog() {
      this.$emit("close-yes-or-no-format-dialog");
      this.clearYesOrNoBlock();
    },

    clearYesOrNoBlock() {
      this.yesOrNoItemNum = 1; // アイテム数のリセット
      this.yesOrNoBlock.title = "";
      this.yesOrNoItem1.content = "";
      this.yesOrNoItem1.answer = "";
      this.yesOrNoItem2.content = "";
      this.yesOrNoItem2.answer = "";
      this.yesOrNoItem3.content = "";
      this.yesOrNoItem3.answer = "";
      requestAnimationFrame(() => {
        this.$refs.observer.reset();
      });
    },
  },
};
</script>
