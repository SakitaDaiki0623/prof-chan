<template>
  <v-dialog
    :value="isShownRankingFormatDialog"
    max-width="800"
    @click:outside="hundleCloseRankingFormatDialog"
    @input="$emit('input', $event.target.isShownRankingFormatDialog)"
  >
    <v-card :color="rankingBlockColor">
      <v-row justify="end" class="mr-2 mt-2">
        <v-btn
          :color="rankingBlockColor"
          @click="hundleCloseRankingFormatDialog"
        >
          <v-icon> mdi-close-outline </v-icon>
        </v-btn>
      </v-row>
      <p class="font-weight-bold text-white text-4xl text-center my-10">
        ランキングブロック作成
      </p>
      <div id="ranking-block-form" class="pa-10 note-box">
        <v-btn
          id="input-ranking-title-button"
          type="submit"
          depressed
          elevation="4"
          small
          tile
          color="green lighten-2"
          class="white--text py-2"
          @click="inputTitleRandomly"
        >
          <v-icon left> mdi-plus </v-icon>ランダムに入力
        </v-btn>
        <ValidationObserver ref="observer" v-slot="{ invalid }">
          <form @submit.prevent="hundleCreateRankingBlock(rankingBlock)">
            <div>
              <label class="form-label-text-block" for="ranking_block_title"
                >タイトル</label
              >
              <ValidationProvider
                v-slot="{ errors }"
                name="タイトル"
                rules="input_required|max:20"
              >
                <input
                  id="ranking_block_title"
                  v-model="rankingBlock.title"
                  class="input-form-ranking-block"
                  name="ranking_block[ranking_block_title]"
                  type="text"
                />
                <span class="red--text text-sm">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <div class="mt-5">
              <label
                class="form-label-text-block"
                for="ranking_block_first_place"
                >1st</label
              >
              <ValidationProvider
                v-slot="{ errors }"
                name="1位"
                rules="input_required|max:20"
              >
                <input
                  id="ranking_block_first_place"
                  v-model="rankingBlock.first_place"
                  class="input-form-ranking-block"
                  name="ranking_block[ranking_block_first_place]"
                />
                <span class="red--text text-sm">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>
            <div class="mt-5">
              <label
                class="form-label-text-block"
                for="ranking_block_second_place"
                >2nd</label
              >
              <ValidationProvider
                v-slot="{ errors }"
                name="2位"
                rules="input_required|max:20"
              >
                <input
                  id="ranking_block_second_place"
                  v-model="rankingBlock.second_place"
                  class="input-form-ranking-block"
                  name="ranking_block[ranking_block_second_place]"
                />
                <span class="red--text text-sm">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>
            <div class="mt-5">
              <label
                class="form-label-text-block"
                for="ranking_block_third_place"
                >3rd</label
              >
              <ValidationProvider
                v-slot="{ errors }"
                name="3位"
                rules="input_required|max:20"
              >
                <input
                  id="ranking_block_third_place"
                  v-model="rankingBlock.third_place"
                  class="input-form-ranking-block"
                  name="ranking_block[ranking_block_third_place]"
                />
                <span class="red--text text-sm">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>

            <div v-if="isProviderSlack && notSharedYet">
              <v-checkbox
                v-model="check"
                label="slackに投稿しますか?"
                :color="rankingBlockColor"
              ></v-checkbox>
              <div class="text-sm">
                ※Slackへの投稿は1日に1回のみです。
              </div>
            </div>
            <div class="text-center mt-3">
              <v-btn
                id="creation_button"
                type="submit"
                depressed
                elevation="4"
                x-large
                :disabled="invalid"
                :color="rankingBlockColor"
                class="white--text"
              >
                ランキングブロックを作成！
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

export default {
  props: {
    isShownRankingFormatDialog: {
      type: Boolean,
      required: true,
    },
    rankingBlockColor: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      rankingBlock: {
        title: "",
        first_place: "",
        second_place: "",
        third_place: "",
      },
      check: false,

      randomeTitles: [
        "アニメ・漫画",
        "カラオケの18番",
        "結婚したい芸能人(既婚者可)",
        "ビデオ・スマホゲーム",
        "映画",
        "アーティスト",
        "言われて嬉しい言葉",
        "コロナ空けで行きたい国",
        "お金を使うときの優先順位",
        "飼いたいペット",
        "頼りになる社員",
        "仲がいい社員",
        "よく行く飲食店",
        "今現在欲しいもの",
      ],
    };
  },
  computed: {
    ...mapState("users", ["currentUser"]),
    isProviderSlack() {
      return this.currentUser.provider == "slack" ? true : false;
    },
    notSharedYet() {
      return this.currentUser.ranking_share_right == "ranking_not_shared_yet"
        ? true
        : false;
    },
  },
  methods: {
    ...mapActions({
      updateCurrentUserRankingShareRight:
        "users/updateCurrentUserRankingShareRight",
    }),
    hundleCreateRankingBlock(rankingBlock) {
      this.createRankingBlock(rankingBlock);
      if (this.isProviderSlack && this.check && this.notSharedYet) {
        this.postToSlackAfterCreate(rankingBlock);
        this.updateCurrentUserRankingShareRight();
      }
      this.hundleCloseRankingFormatDialog();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "ランキングブロックを作成したよ！",
        color: this.rankingBlockColor,
      });
    },
    createRankingBlock(rankingBlock) {
      axios
        .post("/api/v1/ranking_blocks", rankingBlock)
        .then((res) => this.$emit("add-ranking-block", res.data));
    },
    async postToSlackAfterCreate(rankingBlock) {
      const res = await axios.post(
        "/api/v1/ranking_blocks/post_to_slack_after_create",
        rankingBlock
      );
    },
    hundleCloseRankingFormatDialog() {
      this.$emit("close-ranking-format-dialog");
      this.check = false;
      this.clearRankingBlock();
    },
    clearRankingBlock() {
      this.rankingBlock.title = "";
      this.rankingBlock.first_place = "";
      this.rankingBlock.second_place = "";
      this.rankingBlock.third_place = "";
      requestAnimationFrame(() => {
        this.$refs.observer.reset();
      });
    },

    inputTitleRandomly() {
      const randomNum = Math.floor(Math.random() * this.randomeTitles.length);
      this.rankingBlock.title = this.randomeTitles[randomNum];
    },
  },
};
</script>

<style scoped>
.note-box {
  position: relative;
  background-color: #dcedc8;
}
.note-box::before {
  content: "";
  position: absolute;
  border-right: dotted 10px #d7ccc8; /*ドットの大きさ、高さ*/
  height: 90%;
  top: 0.5em; /*位置*/
  left: 0.5em; /*位置*/
}
</style>
