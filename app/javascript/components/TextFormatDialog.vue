<!-- app/javascript/components/TextFormatDialog.vue -->
<template>
  <div>
    <v-dialog
      :value="isShownTextFormatDialog"
      max-width="800"
      persistent
      @input="$emit('input', $event.target.isShownTextFormatDialog)"
    >
      <v-card color="grey">
        <p
          class="font-weight-bold font-prof-default text-gray-600 text-4xl text-center mt-10 mb-10"
        >
          テキストブロック
        </p>
        <div id="text-block-form" class="p-10 bg-prof-card bg-top">
          <ValidationObserver ref="observer" v-slot="{ invalid }">
            <form @submit.prevent="hundleCreateTextBlock(textBlock)">
              <div>
                <label class="form-label" for="text_block_title"
                  >タイトル</label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  name="タイトル"
                  rules="input_required|max:30"
                >
                  <input
                    id="text_block_title"
                    v-model="textBlock.title"
                    class="input-form"
                    name="text_block[text_block_title]"
                    type="text"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>
              <div>
                <label class="form-label" for="text_block_text">テキスト</label>
                <ValidationProvider
                  v-slot="{ errors }"
                  name="テキスト"
                  rules="input_required|max:100"
                >
                  <textarea
                    id="text_block_text"
                    v-model="textBlock.text"
                    class="input-form"
                    name="text_block[text_block_text]"
                    rows="7"
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
                  color="blue-grey darken-2"
                  class="white--text"
                >
                  テキストブロックを作成！
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
    isShownTextFormatDialog: {
      type: Boolean,
      required: true,
    },
  },
  data() {
    return {
      textBlock: {
        title: "",
        text: "",
      },
    };
  },
  methods: {
    ...mapActions("textBlocks", ["createTextBlock"]),

    hundleCreateTextBlock(textBlock) {
      if (textBlock.title == "" || textBlock.title == "") return;
      this.createTextBlock(textBlock);
      this.hundleCloseTextFormatDialog();
    },
    hundleCloseTextFormatDialog() {
      this.clearTextBlock();
      this.$emit("close-text-format-dialog");
    },
    clearTextBlock() {
      this.textBlock = {};
    },
  },
};
</script>


