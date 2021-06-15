<!-- app/javascript/components/FavoriteFormatDialog.vue -->
<template>
  <v-dialog
    :value="isShownFavoriteFormatDialog"
    max-width="500"
    @click:outside="hundleCloseFavoriteFormatDialog"
    @input="$emit('input', $event.target.isShownFavoriteFormatDialog)"
  >
    <v-card :color="favoriteBlockColor">
      <div class="bg-brown-300 pa-3">
        <v-row
          justify="end"
          class="ma-2"
        >
          <v-btn
            :color="favoriteBlockColor"
            @click="hundleCloseFavoriteFormatDialog"
          >
            <v-icon> mdi-close-outline </v-icon>
          </v-btn>
        </v-row>
        <p class="font-weight-bold text-white text-4xl text-center mt-10 mb-10">
          Favorite ブロック作成
        </p>
      </div>
      <div
        id="favorite-block-form"
        class="pa-10 bg-text-prof-block"
      >
        <ValidationObserver
          ref="observer"
          v-slot="{ invalid }"
        >
          <form @submit.prevent="hundleCreateFavoriteBlock(favoriteBlock)">
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
                  v-model="favoriteBlock.category_id"
                  name="favorite[category_id]"
                  class="input-form-favorite-block"
                  :items="categories"
                  item-text="name"
                  item-value="value"
                  color="brown lighten-3"
                  persistent-hint
                  single-line
                />
                <span class="text-red-200">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>
            <div class="mt-5">
              <label
                class="form-label-text-block"
                for="favorite_block_text"
              >テキスト</label>
              <ValidationProvider
                v-slot="{ errors }"
                name="テキスト"
                rules="input_required|max:20"
              >
                <input
                  id="favorite_block_text"
                  v-model="favoriteBlock.text"
                  class="input-form-favorite-block"
                  name="favorite_block[favorite_block_text]"
                >
                <span class="text-red-200">{{ errors[0] }}</span>
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
                Favorite ブロックを作成！
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
    isShownFavoriteFormatDialog: {
      type: Boolean,
      required: true,
    },
    favoriteBlockColor: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      favoriteBlock: {
        category_id: "",
        text: "",
      },
    };
  },
  computed: {
    ...mapState("users", ["currentUser"]),
    ...mapState("activeHash", ["categories"]),
  },
  methods: {
    hundleCreateFavoriteBlock(favoriteBlock) {
      this.createFavoriteBlock(favoriteBlock);
      this.hundleCloseFavoriteFormatDialog();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "Favorite ブロックを作成したよ！",
        color: this.favoriteBlockColor,
      });
    },
    hundleCloseFavoriteFormatDialog() {
      this.$emit("close-favorite-format-dialog");
      this.clearFavoriteBlock();
    },
    createFavoriteBlock(favoriteBlock) {
      axios
        .post("/api/v1/favorite_blocks", favoriteBlock)
        .then((res) => this.$emit("add-favorite-block", res.data));
    },
    clearFavoriteBlock() {
      this.favoriteBlock.category_id = "";
      this.favoriteBlock.text = "";
      requestAnimationFrame(() => {
        this.$refs.observer.reset();
      });
    },
  },
};
</script>
