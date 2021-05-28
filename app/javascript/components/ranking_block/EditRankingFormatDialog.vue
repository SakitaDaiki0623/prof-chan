<!-- app/javascript/components/TextFormatDialog.vue -->
<template>
  <div>
    <v-dialog
      :value="isShownEditRankingFormatDialog"
      max-width="800"
      persistent
      @input="$emit('input', $event.target.isShownEditRankingFormatDialog)"
    >
      <v-card :color="rankingBlockColor">
        <v-row justify="end" class="mr-2 mt-2">
          <v-btn
            :color="rankingBlockColor"
            @click="hundleCloseEditRankingFormatDialog"
          >
            <v-icon> mdi-close-outline </v-icon>
          </v-btn>
        </v-row>
        <p class="font-weight-bold text-white text-4xl text-center mt-10 mb-10">
          ランキングブロックを編集
        </p>
        <div id="ranking-block-form" class="pa-10 note-box">
          <ValidationObserver ref="observer" v-slot="{ invalid }">
            <form @submit.prevent="hundleEditRankingBlock(editRankingBlock)">
              <div>
                <label class="form-label-text-block" for="ranking_block_title"
                  >タイトル</label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  name="タイトル"
                  rules="input_required|max:50"
                >
                  <input
                    id="ranking_block_title"
                    :value="editRankingBlock.title"
                    class="input-form-ranking-block"
                    name="ranking_block[ranking_block_title]"
                    type="text"
                    @input="editRankingBlock.title = $event.target.value"
                  />
                  <span class="red--text">{{ errors[0] }}</span>
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
                  rules="input_required|max:50"
                >
                  <input
                    id="ranking_block_first_place"
                    :value="editRankingBlock.first_place"
                    class="input-form-ranking-block"
                    name="ranking_block[ranking_block_first_place]"
                    @input="editRankingBlock.first_place = $event.target.value"
                  />
                  <span class="red--text">{{ errors[0] }}</span>
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
                  rules="input_required|max:50"
                >
                  <input
                    id="ranking_block_second_place"
                    :value="editRankingBlock.second_place"
                    class="input-form-ranking-block"
                    name="ranking_block[ranking_block_second_place]"
                    @input="editRankingBlock.second_place = $event.target.value"
                  />
                  <span class="red--text">{{ errors[0] }}</span>
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
                  rules="input_required|max:50"
                >
                  <input
                    id="ranking_block_third_place"
                    :value="editRankingBlock.third_place"
                    class="input-form-ranking-block"
                    name="ranking_block[ranking_block_third_place]"
                    @input="editRankingBlock.third_place = $event.target.value"
                  />
                  <span class="red--text">{{ errors[0] }}</span>
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
                  :color="rankingBlockColor"
                  class="white--text"
                >
                  ランキングブロックを更新！
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

// components ----------

export default {
  props: {
    isShownEditRankingFormatDialog: {
      type: Boolean,
      required: true,
    },
    editRankingBlock: {
      type: Object,
      required: true,
    },
    rankingBlockColor: {
      type: String,
      required: true,
    },
  },
  data() {
    return {};
  },
  methods: {
    hundleEditRankingBlock(editRankingBlock) {
      this.patchRankingBlock(editRankingBlock);
      this.hundleCloseEditRankingFormatDialog();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "ランキングブロックを更新したよ！",
        color: this.rankingBlockColor,
      });
    },
    patchRankingBlock(editRankingBlock) {
      axios
        .patch(
          `/api/v1/ranking_blocks/${editRankingBlock.id}`,
          editRankingBlock
        )
        .then((res) => this.$emit("update-ranking-block", res.data));
    },

    hundleCloseEditRankingFormatDialog() {
      this.$emit("close-edit-ranking-format-dialog");
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
