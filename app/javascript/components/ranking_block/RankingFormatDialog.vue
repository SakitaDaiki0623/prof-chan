<!-- app/javascript/components/TextFormatDialog.vue -->
<template>
  <div>
    <v-dialog
      :value="isShownRankingFormatDialog"
      max-width="800"
      persistent
      @input="$emit('input', $event.target.isShownRankingFormatDialog)"
    >
      <v-card :color="rankingBlockColorForFlashMessage">
        <v-row justify="end" class="mr-2 mt-2">
          <v-btn
            :color="rankingBlockColorForFlashMessage"
            @click="hundleCloseRankingFormatDialog"
          >
            ✖︎
          </v-btn>
        </v-row>
        <p
          class="font-weight-bold font-prof-default text-white text-4xl text-center mt-10 mb-10"
        >
          ランキングブロック作成
        </p>
        <div id="ranking-block-form" class="p-10 bg-ranking-prof-block bg-top">
          <ValidationObserver ref="observer" v-slot="{ invalid }">
            <form @submit.prevent="hundleCreateRankingBlock(rankingBlock)">
              <div>
                <label class="form-label-ranking-block" for="ranking_block_title"
                  >タイトル</label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  name="タイトル"
                  rules="input_required|max:50"
                >
                  <input
                    id="ranking_block_title"
                    v-model="rankingBlock.title"
                    class="input-form-ranking-block"
                    name="ranking_block[ranking_block_title]"
                    type="text"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>
              <div class="mt-5">
                <label class="form-label-ranking-block" for="ranking_block_first_place"
                  >1位</label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  name="1位"
                  rules="input_required|max:50"
                >
                  <input
                    id="ranking_block_first_place"
                    v-model="rankingBlock.firstPlace"
                    class="input-form-ranking-block"
                    name="ranking_block[ranking_block_first_place]"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>
              <div class="mt-5">
                <label class="form-label-ranking-block" for="ranking_block_second_place"
                  >2位</label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  name="2位"
                  rules="input_required|max:50"
                >
                  <input
                    id="ranking_block_second_place"
                    v-model="rankingBlock.secondPlace"
                    class="input-form-ranking-block"
                    name="ranking_block[ranking_block_second_place]"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>
              <div class="mt-5">
                <label class="form-label-ranking-block" for="ranking_block_third_place"
                  >3位</label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  name="3位"
                  rules="input_required|max:50"
                >
                  <input
                    id="ranking_block_third_place"
                    v-model="rankingBlock.thirdPlace"
                    class="input-form-ranking-block"
                    name="ranking_block[ranking_block_third_place]"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>
              <div class="text-center mt-3">
                <v-btn
                  id="creation_button"
                  type="submit"
                  depressed
                  elevation="4"
                  x-large
                  :disabled="invalid"
                  :color="rankingBlockColorForFlashMessage"
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
  </div>
</template>

<script>
// plugins
import axios from "axios";
import { mapActions } from "vuex";

// components ----------

export default {
  props: {
    isShownRankingFormatDialog: {
      type: Boolean,
      required: true,
    },
    rankingBlockColorForFlashMessage: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      rankingBlock: {
        title: "",
        firstPlace: "",
        secondPlace: "",
        thirdPlace: "",
      },
    };
  },
  methods: {
    ...mapActions("rankingBlocks", ["createRankingBlock"]),

    hundleCreateRankingBlock(rankingBlock) {
      this.createRankingBlock(rankingBlock);
      this.hundleCloseRankingFormatDialog();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "ランキングブロックを作成したよ！",
        color: this.rankingBlockColorForFlashMessage,
      });
    },
    hundleCloseRankingFormatDialog() {
      this.$emit("close-ranking-format-dialog");
      this.clearRankingBlock();
    },
    clearRankingBlock() {
      this.rankingBlock.title = "";
      this.rankingBlock.firstPlace = "";
      this.rankingBlock.secondPlace = "";
      this.rankingBlock.thirdPlace = "";
      requestAnimationFrame(() => {
        this.$refs.observer.reset();
      });
    },
  },
};
</script>


