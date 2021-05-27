<!-- app/javascript/components/FavoriteFormatDialog.vue -->
<template>
  <div>
    <v-dialog
      :value="isShownFavoriteFormatDialog"
      max-width="400"
      persistent
      @input="$emit('input', $event.target.isShownFavoriteFormatDialog)"
    >
      <v-card :color="favoriteBlockColor">
        <div class="bg-brown-300 p-3">
          <v-row justify="end" class="m-2">
            <v-btn
              :color="favoriteBlockColor"
              @click="hundleCloseFavoriteFormatDialog"
            >
              <v-icon> mdi-close-outline </v-icon>
            </v-btn>
          </v-row>
          <p
            class="font-weight-bold text-white text-4xl text-center mt-10 mb-10"
          >
            Favorite ブロック作成
          </p>
        </div>
        <div id="favorite-block-form" class="p-10 bg-text-prof-block">
          <ValidationObserver ref="observer" v-slot="{ invalid }">
            <form @submit.prevent="hundleCreateFavoriteBlock(favoriteBlock)">
              <div>
                <label
                  class="form-label-text-block"
                  for="favorite_block_category_id"
                  >カテゴリー</label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  name="出身地"
                  rules="select_required"
                >
                  <select
                    id="favorite_category_id"
                    v-model="favoriteBlock.category_id"
                    name="favorite[category_id]"
                    class="input-form-basic-block"
                  >
                    <option
                      v-for="category in categories"
                      :key="category.value"
                      :value="category.value"
                    >
                      {{ category.name }}
                    </option>
                  </select>
                  <span class="text-red-200">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>
              <div class="mt-5">
                <label class="form-label-text-block" for="favorite_block_text"
                  >テキスト</label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  name="テキスト"
                  rules="input_required|max:20"
                >
                  <input
                    id="favorite_block_text"
                    v-model="favoriteBlock.text"
                    class="input-form-text-block"
                    name="favorite_block[favorite_block_text]"
                  />
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
  </div>
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
      categories: [
        { value: "1", name: "音楽" },
        { value: "2", name: "ゲームアプリ" },
        { value: "3", name: "キャラクター" },
        { value: "4", name: "俳優・女優" },
        { value: "5", name: "食べ物" },
        { value: "6", name: "動物" },
        { value: "7", name: "スポーツ" },
        { value: "8", name: "本" },
        { value: "9", name: "場所" },
        { value: "10", name: "お菓子" },
        { value: "11", name: "お酒" },
        { value: "12", name: "飲食店" },
        { value: "13", name: "歌手" },
        { value: "14", name: "YouTuber" },
        { value: "15", name: "お笑い芸人" },
      ],
    };
  },
  computed: {
    ...mapState("users", ["currentUser"]),
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
