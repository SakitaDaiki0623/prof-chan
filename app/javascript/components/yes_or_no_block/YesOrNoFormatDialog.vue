<template>
  <v-dialog
    :value="isShownYesOrNoFormatDialog"
    max-width="800"
    @click:outside="hundleCloseYesOrNoFormatDialog"
    @input="$emit('input', $event.target.isShownYesOrNoFormatDialog)"
  >
    <v-card :color="yesOrNoBlockColor">
      <v-row justify="end" class="mr-2 mt-2">
        <v-btn
          :color="yesOrNoBlockColor"
          @click="hundleCloseYesOrNoFormatDialog"
        >
          <v-icon> mdi-close-outline </v-icon>
        </v-btn>
      </v-row>
      <p class="font-weight-bold text-white text-4xl text-center mt-10">
        Yes or No ブロック
      </p>

      <div
        id="yes-or-no-block-form"
        class="pa-10 note-box"
        color="orange lighten-4"
      >
        <v-row>
          <v-col cols="12" sm="6">
            <v-btn
              id="input-yes-or-no-title-button"
              type="submit"
              depressed
              elevation="4"
              small
              tile
              color="orange lighten-2"
              class="white--text py-2"
              @click="inputTitleRandomly"
            >
              <v-icon left> mdi-plus </v-icon>ランダムに入力
            </v-btn>
          </v-col>
          <v-spacer />
          <v-col cols="12" sm="6">
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
          </v-col>
        </v-row>

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
              <label class="form-label-text-block" for="yes_or_no_block_title"
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
                <span class="red--text text-sm">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <!-- Item Form -->
            <YesOrNoBlockItem
              yes-or-no-block-item-id="create-yes-or-no-item-1"
              :yes-or-no-item="yesOrNoItem1"
              :yes-or-no-name-for-validation="yesOrNoNameForValidation1"
              :answer-name-for-validation="answerNameForValidation1"
            />
            <YesOrNoBlockItem
              v-if="yesOrNoItemNum >= 2"
              yes-or-no-block-item-id="create-yes-or-no-item-2"
              :yes-or-no-item="yesOrNoItem2"
              :yes-or-no-name-for-validation="yesOrNoNameForValidation2"
              :answer-name-for-validation="answerNameForValidation2"
            />
            <YesOrNoBlockItem
              v-if="yesOrNoItemNum >= 3"
              yes-or-no-block-item-id="create-yes-or-no-item-3"
              :yes-or-no-item="yesOrNoItem3"
              :yes-or-no-name-for-validation="yesOrNoNameForValidation3"
              :answer-name-for-validation="answerNameForValidation3"
            />

            <div v-if="isProviderSlack && notSharedYet">
              <v-checkbox
                v-model="check"
                label="slackに投稿しますか?"
                :color="yesOrNoBlockColor"
              ></v-checkbox>
              <div class="text-sm">
                ※Slackへの投稿は1日に1回のみです。
              </div>
            </div>

            <div class="text-center pa-10">
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
</template>

<script>
import axios from "axios";
import { mapActions, mapState } from "vuex";

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
      yesOrNoItemNum: 1,
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

      randomeTitles: [
        {
          title: "現在の交際",
          contents: [
            "喧嘩はする？",
            "同棲の予定はある(orしている)？",
            "相手に嫉妬することある？",
            "相手をSNSに載せることは多い？",
            "結婚の予定はある？",
          ],
        },
        {
          title: "二項対立あるある",
          contents: [
            "山より海が好きだ",
            "犬より猫派だ",
            "夜型よりも朝方だ",
            "テレビよりYouTubeをよく見る",
            "朝はご飯よりもパンを食べる",
            "眼鏡よりコンタクトをよくつける",
            "アウトドアよりインドア派",
            "きのこの山よりたけのこの里！",
            "洋食よりも和食だ",
            "WindowsよりMAC",
          ],
        },
        {
          title: "将来の自分",
          contents: [
            "一戸建てよりマンションに住む？",
            "専業主婦より共働きしていたい？",
            "都会よりも田舎に住みたい？",
          ],
        },
        {
          title: "仕事・コミュニケーション",
          contents: [
            "自分から話を始める",
            "人から指図されるのは嫌い",
            "深く考えるより、すぐに行動",
            "チームを引っ張りたい",
            "人の世話をするのが好き",
            "聞き上手だ",
          ],
        },
      ],

      // Validator
      yesOrNoNameForValidation1: "1番目の質問",
      answerNameForValidation1: "1番目の答え",
      yesOrNoNameForValidation2: "2番目の質問",
      answerNameForValidation2: "2番目の答え",
      yesOrNoNameForValidation3: "3番目の質問",
      answerNameForValidation3: "3番目の答え",

      check: false,
    };
  },
  computed: {
    ...mapState("users", ["currentUser"]),
    isProviderSlack() {
      return this.currentUser.provider == "slack" ? true : false;
    },
    notSharedYet() {
      return this.currentUser.yes_or_no_share_right ==
        "yes_or_no_not_shared_yet"
        ? true
        : false;
    },
  },
  methods: {
    ...mapActions({
      createYesOrNoBlock: "yesOrNoBlocks/createYesOrNoBlock",
      updateCurrentUserYesOrNoShareRight:
        "users/updateCurrentUserYesOrNoShareRight",
    }),
    addYesOrNoItemNum() {
      this.yesOrNoItemNum++;
    },
    deleteYesOrNoItemNum() {
      this.yesOrNoItemNum--;
      if (this.yesOrNoItemNum == 2) {
        this.yesOrNoItem3.content = "";
        this.yesOrNoItem3.answer = "";
      } else if (this.yesOrNoItemNum == 1) {
        this.yesOrNoItem2.content = "";
        this.yesOrNoItem2.answer = "";
      }
    },
    hundleCreateYesOrNoBlock(
      yesOrNoBlock,
      yesOrNoItem1,
      yesOrNoItem2,
      yesOrNoItem3
    ) {
      const params = {
        yes_or_no_title: yesOrNoBlock.title,
        yes_or_no_item_content1: yesOrNoItem1.content,
        yes_or_no_item_answer1: yesOrNoItem1.answer,
        yes_or_no_item_content2: yesOrNoItem2.content,
        yes_or_no_item_answer2: yesOrNoItem2.answer,
        yes_or_no_item_content3: yesOrNoItem3.content,
        yes_or_no_item_answer3: yesOrNoItem3.answer,
      };
      this.createYesOrNoBlock(params);
      if (this.isProviderSlack && this.check && this.notSharedYet) {
        this.postToSlackAfterCreate(params);
        this.updateCurrentUserYesOrNoShareRight();
      }
      this.hundleCloseYesOrNoFormatDialog();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "Yes or No ブロックを作成したよ！",
        color: this.yesOrNoBlockColor,
      });
    },
    async postToSlackAfterCreate(params) {
      const res = await axios.post(
        "/api/v1/yes_or_no_blocks/post_to_slack_after_create",
        params
      );
    },
    hundleCloseYesOrNoFormatDialog() {
      this.$emit("close-yes-or-no-format-dialog");
      this.check = false;
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
    inputTitleRandomly() {
      const randomNum = Math.floor(Math.random() * this.randomeTitles.length);
      const selectedRandomTitle = JSON.parse(
        JSON.stringify(this.randomeTitles[randomNum])
      );

      this.yesOrNoBlock.title = selectedRandomTitle.title;

      if (this.yesOrNoItemNum == 1) {
        const randomItemContentIndexForItem1 = Math.floor(
          Math.random() * selectedRandomTitle.contents.length
        );
        this.yesOrNoItem1.content = selectedRandomTitle.contents.splice(
          randomItemContentIndexForItem1,
          1
        )[0];
      } else if (this.yesOrNoItemNum == 2) {
        const randomItemContentIndexForItem1 = Math.floor(
          Math.random() * selectedRandomTitle.contents.length
        );
        this.yesOrNoItem1.content = selectedRandomTitle.contents.splice(
          randomItemContentIndexForItem1,
          1
        )[0];
        const randomItemContentIndexForItem2 = Math.floor(
          Math.random() * selectedRandomTitle.contents.length
        );
        this.yesOrNoItem2.content = selectedRandomTitle.contents.splice(
          randomItemContentIndexForItem2,
          1
        )[0];
      } else if (this.yesOrNoItemNum == 3) {
        const randomItemContentIndexForItem1 = Math.floor(
          Math.random() * selectedRandomTitle.contents.length
        );
        this.yesOrNoItem1.content = selectedRandomTitle.contents.splice(
          randomItemContentIndexForItem1,
          1
        )[0];
        const randomItemContentIndexForItem2 = Math.floor(
          Math.random() * selectedRandomTitle.contents.length
        );
        this.yesOrNoItem2.content = selectedRandomTitle.contents.splice(
          randomItemContentIndexForItem2,
          1
        )[0];
        const randomItemContentIndexForItem3 = Math.floor(
          Math.random() * selectedRandomTitle.contents.length
        );
        this.yesOrNoItem3.content = selectedRandomTitle.contents.splice(
          randomItemContentIndexForItem3,
          1
        )[0];
      }
    },
  },
};
</script>

<style scoped>
.note-box {
  position: relative;
  background-color: #ffe0b2;
  min-height: 670px;
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
