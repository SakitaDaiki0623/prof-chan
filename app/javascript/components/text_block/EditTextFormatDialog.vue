<template>
  <v-dialog
    :value="isShownEditTextFormatDialog"
    max-width="800"
    @click:outside="hundleCloseEditTextFormatDialog"
    @input="$emit('input', $event.target.isShownEditTextFormatDialog)"
  >
    <v-card :color="textBlockColor">
      <v-row
        justify="end"
        class="mr-2 mt-2"
      >
        <v-btn
          :color="textBlockColor"
          @click="hundleCloseEditTextFormatDialog"
        >
          <v-icon> mdi-close-outline </v-icon>
        </v-btn>
      </v-row>
      <p class="font-weight-bold text-white text-4xl text-center mt-10 mb-10">
        テキストブロックを編集
      </p>
      <div
        id="text-block-form"
        class="pa-10 note-box"
      >
        <ValidationObserver
          ref="observer"
          v-slot="{ invalid }"
        >
          <form @submit.prevent="hundleEditTextBlock(editTextBlock)">
            <div>
              <label
                class="form-label-text-block"
                for="text_block_title"
              >タイトル</label>
              <ValidationProvider
                v-slot="{ errors }"
                name="タイトル"
                rules="input_required|max:50"
              >
                <input
                  id="text_block_title"
                  :value="editTextBlock.title"
                  class="input-form-text-block"
                  name="text_block[text_block_title]"
                  type="text"
                  @input="editTextBlock.title = $event.target.value"
                >
                <span class="red--text">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>
            <div class="mt-5">
              <label
                class="form-label-text-block"
                for="text_block_text"
              >テキスト</label>
              <ValidationProvider
                v-slot="{ errors }"
                name="テキスト"
                rules="input_required|max:400"
              >
                <textarea
                  id="text_block_text"
                  :value="editTextBlock.text"
                  class="input-form-text-block"
                  name="text_block[text_block_text]"
                  rows="7"
                  @input="editTextBlock.text = $event.target.value"
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
                :color="textBlockColor"
                class="white--text"
              >
                テキストブロックを更新！
              </v-btn>
            </div>
          </form>
        </ValidationObserver>
      </div>
    </v-card>
  </v-dialog>
</template>

<script>
// plugins
import axios from "axios";
import { mapActions } from "vuex";

// components ----------

export default {
  props: {
    isShownEditTextFormatDialog: {
      type: Boolean,
      required: true,
    },
    editTextBlock: {
      type: Object,
      required: true,
    },
    textBlockColor: {
      type: String,
      required: true,
    },
  },
  data() {
    return {};
  },
  methods: {
    hundleEditTextBlock(editTextBlock) {
      this.patchTextBlock(editTextBlock);
      this.hundleCloseEditTextFormatDialog();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "テキストブロックを更新したよ！",
        color: this.textBlockColor,
      });
    },
    patchTextBlock(editTextBlock) {
      axios
        .patch(`/api/v1/text_blocks/${editTextBlock.id}`, editTextBlock)
        .then((res) => this.$emit("update-text-block", res.data));
    },

    hundleCloseEditTextFormatDialog() {
      this.$emit("close-edit-text-format-dialog");
    },
  },
};
</script>

<style scoped>
.note-box {
  position: relative;
  background: #a7ffeb;
}

.note-box::after {
  content: "＊*"; /*花に見せかけるためのアスタリスク*/
  color: #fff; /* アスタリスクの色 */
  display: inline-block;
  font-size: 30px; /* アスタリスクの大きさ */
  font-weight: bold;
  position: absolute;
  top: 0px;
  left: 0px;
  transform: rotate(20deg);
  -moz-transform: rotate(20deg);
  -webkit-transform: rotate(20deg);
  -o-transform: rotate(20deg);
  text-shadow: 0px 0px 6px #eaa8bf, 0px 0px 4px #eaa8bf, 0 0 0.5px #eaa8bf; /* アスタリスク周りの影 */
}
</style>
