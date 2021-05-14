<!-- app/javascript/components/TextFormatDialog.vue -->
<template>
  <div>
    <v-dialog
      :value="isShownTextFormatDialog"
      max-width="800"
      persistent
      @input="$emit('input', $event.target.isShownTextFormatDialog)"
    >
      <v-card :color="textBlockColor">
        <v-row
          justify="end"
          class="mr-2 mt-2"
        >
          <v-btn
            :color="textBlockColor"
            @click="hundleCloseTextFormatDialog"
          >
            ✖︎
          </v-btn>
        </v-row>
        <p class="font-weight-bold text-white text-4xl text-center mt-10 mb-10">
          テキストブロック作成
        </p>
        <div
          id="text-block-form"
          class="p-10 bg-text-prof-block bg-top"
        >
          <ValidationObserver
            ref="observer"
            v-slot="{ invalid }"
          >
            <form @submit.prevent="hundleCreateTextBlock(textBlock)">
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
                    v-model="textBlock.title"
                    class="input-form-text-block"
                    name="text_block[text_block_title]"
                    type="text"
                  >
                  <span class="text-red-400">{{ errors[0] }}</span>
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
                  rules="input_required|max:200"
                >
                  <textarea
                    id="text_block_text"
                    v-model="textBlock.text"
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
                  :color="textBlockColor"
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
    textBlockColor: {
      type: String,
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
      if (textBlock.title == "" || textBlock.text == "") return;
      this.createTextBlock(textBlock);
      if (confirm("slackに通知しますか?")) {
        this.postToSlackAfterCreate(textBlock);
      }
      this.hundleCloseTextFormatDialog();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "テキストブロックを作成したよ！",
        color: this.textBlockColor,
      });
    },
    async postToSlackAfterCreate(textBlock) {
      const res = await axios.post(
        "/api/v1/text_blocks/post_to_slack_after_create",
        textBlock
      );
    },
    hundleCloseTextFormatDialog() {
      this.$emit("close-text-format-dialog");
      this.clearTextBlock();
    },
    clearTextBlock() {
      this.textBlock.title = "";
      this.textBlock.text = "";
      requestAnimationFrame(() => {
        this.$refs.observer.reset();
      });
    },
  },
};
</script>


