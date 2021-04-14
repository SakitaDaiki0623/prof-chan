<!-- app/javascript/components/TextFormatDialog.vue -->
<template>
  <div>
    <v-dialog
      :value="isShownEditTextFormatDialog"
      max-width="800"
      persistent
      @input="$emit('input', $event.target.isShownEditTextFormatDialog)"
    >
      <v-card color="teal lighten-3">
        <v-row justify="end" class="mr-2 mt-2">
          <v-btn
            color="teal lighten-4"
            @click="hundleCloseEditTextFormatDialog"
          >
            ✖︎
          </v-btn>
        </v-row>
        <p
          class="font-weight-bold font-prof-default text-white text-4xl text-center mt-10 mb-10"
        >
          テキストブロックを編集
        </p>
        <div id="text-block-form" class="p-10 bg-text-prof-block bg-top">
          <ValidationObserver ref="observer" v-slot="{ invalid }">
            <form @submit.prevent="hundleEditTextBlock(editTextBlock)">
              <div>
                <label class="form-label-text-block" for="text_block_title"
                  >タイトル</label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  name="タイトル"
                  rules="input_required|max:30"
                >
                  <input
                    id="text_block_title"
                    v-model="editTextBlock.title"
                    class="input-form-text-block"
                    name="text_block[text_block_title]"
                    type="text"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>
              <div class="mt-5">
                <label class="form-label-text-block" for="text_block_text"
                  >テキスト</label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  name="テキスト"
                  rules="input_required|max:100"
                >
                  <textarea
                    id="text_block_text"
                    v-model="editTextBlock.text"
                    class="input-form-text-block"
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
                  color="teal lighten-3"
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
  </div>
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
  },
  methods: {
    ...mapActions("textBlocks", ["patchTextBlock"]),
    hundleEditTextBlock(editTextBlock) {
      this.patchTextBlock(editTextBlock);
      this.hundleCloseEditTextFormatDialog();
    },

    hundleCloseEditTextFormatDialog() {
      this.$emit("close-edit-text-format-dialog");
    },
  },
};
</script>


