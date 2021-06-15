<template>
  <v-dialog
    :value="isShownEditFavoriteFormatDialog"
    max-width="500"
    @click:outside="hundleCloseEditFavoriteFormatDialog"
    @input="$emit('input', $event.target.isShownEditFavoriteFormatDialog)"
  >
    <v-card :color="favoriteBlockColor">
      <div class="bg-brown-300 pa-3">
        <v-row
          justify="end"
          class="ma-2"
        >
          <v-btn
            :color="favoriteBlockColor"
            @click="hundleCloseEditFavoriteFormatDialog"
          >
            <v-icon> mdi-close-outline </v-icon>
          </v-btn>
        </v-row>
        <p class="font-weight-bold text-white text-4xl text-center mt-10 mb-10">
          Favorite ブロック編集
        </p>
      </div>
      <div
        id="text-block-form"
        class="pa-10 bg-text-prof-block bg-top"
      >
        <ValidationObserver
          ref="observer"
          v-slot="{ invalid }"
        >
          <form @submit.prevent="hundleEditFavoriteBlock(editFavoriteBlock)">
            <div>
              <label
                class="form-label-text-block"
                for="favorite_block_category_id"
              >カテゴリー</label>
              <ValidationProvider
                v-slot="{ errors }"
                name="カテゴリー"
                rules="select_required"
              >
                <v-select
                  id="favorite_category_id"
                  v-model="editFavoriteBlock.title"
                  name="favorite[category_id]"
                  class="input-form-favorite-block"
                  :items="categories"
                  item-text="name"
                  item-value="name"
                  color="brown lighten-3"
                  persistent-hint
                  single-line
                />
                <span class="red--text text--lighten-3">{{ errors[0] }}</span>
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
                rules="input_required|max:20"
              >
                <input
                  id="text_block_text"
                  :value="editFavoriteBlock.text"
                  class="input-form-favorite-block"
                  name="text_block[text_block_text]"
                  @input="editFavoriteBlock.text = $event.target.value"
                >
                <span class="red--text text--lighten-3">{{ errors[0] }}</span>
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
                :color="favoriteBlockColor"
                class="white--text"
              >
                Favorite ブロックを更新！
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
import { mapState } from "vuex";

// components ----------

export default {
  props: {
    isShownEditFavoriteFormatDialog: {
      type: Boolean,
      required: true,
    },
    editFavoriteBlock: {
      type: Object,
      required: true,
    },
    favoriteBlockColor: {
      type: String,
      required: true,
    },
  },
  data() {
    return {};
  },
  computed: {
    ...mapState("activeHash", ["categories"]),
  },
  methods: {
    hundleEditFavoriteBlock(editFavoriteBlock) {
      // category_idの変換
      const selectedCategory = this.categories.find(
        (category) => category.name == editFavoriteBlock.title
      );
      editFavoriteBlock.category_id = selectedCategory.value;

      this.patchFavoriteBlock(editFavoriteBlock);
      this.hundleCloseEditFavoriteFormatDialog();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "Favorite ブロックを更新したよ！",
        color: this.favoriteBlockColor,
      });
    },
    patchFavoriteBlock(editFavoriteBlock) {
      axios
        .patch(
          `/api/v1/favorite_blocks/${editFavoriteBlock.id}`,
          editFavoriteBlock
        )
        .then((res) => this.$emit("update-favorite-block", res.data));
    },

    hundleCloseEditFavoriteFormatDialog() {
      this.$emit("close-edit-favorite-format-dialog");
    },
  },
};
</script>
