<template>
  <v-dialog
    :value="isShownEditMyFavoriteFormatDialog"
    max-width="1000"
    persistent
    @input="$emit('input', $event.target.isShownEditMyFavoriteFormatDialog)"
  >
    <v-container
      class="my-favorite-block-bg"
      id="edit-my-favorite-block-container"
    >
      <v-row justify="end">
        <v-btn
          id="cancel-edit-my-favorite-block-button"
          tile
          small
          color="teal lighten-4"
          @click="hundleCloseEditMyFavoriteFormatDialog"
        >
          ✖︎
        </v-btn>
      </v-row>
      <p class="font-weight-bold text-4xl text-gray-600 text-center mt-10">
        My Favorites 編集
      </p>
      <p class="font-weight-bold text-xl text-gray-600 text-center mb-10">
        項目ごとに好きなものをひとつだけ入力してね♪
      </p>
      <ValidationObserver ref="observer" v-slot="{ invalid }">
        <form @submit.prevent="hundleUpdateMyFavoriteBlock">
          <v-row class="mt-6" no-gutters>
            <v-col cols="12" sm="3">
              <v-card class="pa-2" height="130px" color="brown lighten-5">
                <label class="form-label-text-block">漫画・アニメ</label>
                <ValidationProvider v-slot="{ errors }" rules="max_no_field:15">
                  <input
                    id="anime-manga-form"
                    type="text"
                    class="input-form-text-block"
                    :value="editMyFavoriteBlock.manga_anime"
                    @input="
                      editMyFavoriteBlock.manga_anime = $event.target.value
                    "
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </v-card>
            </v-col>
            <v-col cols="12" sm="3">
              <v-card class="pa-2" height="130px" color="brown lighten-5">
                <label class="form-label-text-block">ゲーム・アプリ</label>
                <ValidationProvider v-slot="{ errors }" rules="max_no_field:15">
                  <input
                    id="game-app-form"
                    type="text"
                    class="input-form-text-block"
                    :value="editMyFavoriteBlock.game_app"
                    @input="editMyFavoriteBlock.game_app = $event.target.value"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </v-card>
            </v-col>
            <v-col cols="12" sm="3">
              <v-card class="pa-2" height="130px" color="brown lighten-5">
                <label class="form-label-text-block">キャラクター</label>
                <ValidationProvider v-slot="{ errors }" rules="max_no_field:15">
                  <input
                    id="character-form"
                    type="text"
                    class="input-form-text-block"
                    :value="editMyFavoriteBlock.character"
                    @input="editMyFavoriteBlock.character = $event.target.value"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </v-card>
            </v-col>
            <v-col cols="12" sm="3">
              <v-card class="pa-2" height="130px" color="brown lighten-5">
                <label class="form-label-text-block">俳優・女優</label>
                <ValidationProvider v-slot="{ errors }" rules="max_no_field:15">
                  <input
                    id="actor-form"
                    type="text"
                    class="input-form-text-block"
                    :value="editMyFavoriteBlock.actor"
                    @input="editMyFavoriteBlock.actor = $event.target.value"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </v-card>
            </v-col>
            <v-col cols="12" sm="3">
              <v-card class="pa-2" height="130px" color="brown lighten-5">
                <label class="form-label-text-block">音楽</label>
                <ValidationProvider v-slot="{ errors }" rules="max_no_field:15">
                  <input
                    id="music-form"
                    type="text"
                    class="input-form-text-block"
                    :value="editMyFavoriteBlock.music"
                    @input="editMyFavoriteBlock.music = $event.target.value"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </v-card>
            </v-col>
            <v-col cols="12" sm="3">
              <v-card class="pa-2" height="130px" color="brown lighten-5">
                <label class="form-label-text-block">食べ物</label>
                <ValidationProvider v-slot="{ errors }" rules="max_no_field:15">
                  <input
                    id="food-form"
                    type="text"
                    class="input-form-text-block"
                    :value="editMyFavoriteBlock.food"
                    @input="editMyFavoriteBlock.food = $event.target.value"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </v-card>
            </v-col>
            <v-col cols="12" sm="3">
              <v-card class="pa-2" height="130px" color="brown lighten-5">
                <label class="form-label-text-block">動物</label>
                <ValidationProvider v-slot="{ errors }" rules="max_no_field:15">
                  <input
                    id="animal-form"
                    type="text"
                    class="input-form-text-block"
                    :value="editMyFavoriteBlock.animal"
                    @input="editMyFavoriteBlock.animal = $event.target.value"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </v-card>
            </v-col>
            <v-col cols="12" sm="3">
              <v-card class="pa-2" height="130px" color="brown lighten-5">
                <label class="form-label-text-block">スポーツ</label>
                <ValidationProvider v-slot="{ errors }" rules="max_no_field:15">
                  <input
                    id="sports-form"
                    type="text"
                    class="input-form-text-block"
                    :value="editMyFavoriteBlock.sports"
                    @input="editMyFavoriteBlock.sports = $event.target.value"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </v-card>
            </v-col>
            <v-col cols="12" sm="3">
              <v-card class="pa-2" height="130px" color="brown lighten-5">
                <label class="form-label-text-block">本</label>
                <ValidationProvider v-slot="{ errors }" rules="max_no_field:15">
                  <input
                    id="book-form"
                    type="text"
                    class="input-form-text-block"
                    :value="editMyFavoriteBlock.book"
                    @input="editMyFavoriteBlock.book = $event.target.value"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </v-card>
            </v-col>
            <v-col cols="12" sm="3">
              <v-card class="pa-2" height="130px" color="brown lighten-5">
                <label class="form-label-text-block">場所</label>
                <ValidationProvider v-slot="{ errors }" rules="max_no_field:15">
                  <input
                    id="place-form"
                    type="text"
                    class="input-form-text-block"
                    :value="editMyFavoriteBlock.place"
                    @input="editMyFavoriteBlock.place = $event.target.value"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </v-card>
            </v-col>
            <v-col cols="12" sm="3">
              <v-card class="pa-2" height="130px" color="brown lighten-5">
                <label class="form-label-text-block">お菓子</label>
                <ValidationProvider v-slot="{ errors }" rules="max_no_field:15">
                  <input
                    id="snack-form"
                    type="text"
                    class="input-form-text-block"
                    :value="editMyFavoriteBlock.snack"
                    @input="editMyFavoriteBlock.snack = $event.target.value"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </v-card>
            </v-col>
            <v-col cols="12" sm="3">
              <v-card class="pa-2" height="130px" color="brown lighten-5">
                <label class="form-label-text-block">お酒</label>
                <ValidationProvider v-slot="{ errors }" rules="max_no_field:15">
                  <input
                    id="alcohol-drink-form"
                    type="text"
                    class="input-form-text-block"
                    :value="editMyFavoriteBlock.alcohol_drink"
                    @input="
                      editMyFavoriteBlock.alcohol_drink = $event.target.value
                    "
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </v-card>
            </v-col>
            <v-col cols="12" sm="3">
              <v-card class="pa-2" height="130px" color="brown lighten-5">
                <label class="form-label-text-block">飲食店</label>
                <ValidationProvider v-slot="{ errors }" rules="max_no_field:15">
                  <input
                    id="restaurants-form"
                    type="text"
                    class="input-form-text-block"
                    :value="editMyFavoriteBlock.restaurants"
                    @input="
                      editMyFavoriteBlock.restaurants = $event.target.value
                    "
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </v-card>
            </v-col>
            <v-col cols="12" sm="3">
              <v-card class="pa-2" height="130px" color="brown lighten-5">
                <label class="form-label-text-block">歌手</label>
                <ValidationProvider v-slot="{ errors }" rules="max_no_field:15">
                  <input
                    id="musician-form"
                    type="text"
                    class="input-form-text-block"
                    :value="editMyFavoriteBlock.musician"
                    @input="editMyFavoriteBlock.musician = $event.target.value"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </v-card>
            </v-col>
            <v-col cols="12" sm="3">
              <v-card class="pa-2" height="130px" color="brown lighten-5">
                <label class="form-label-text-block">YouTuber</label>
                <ValidationProvider v-slot="{ errors }" rules="max_no_field:15">
                  <input
                    id="youtuber-form"
                    type="text"
                    class="input-form-text-block"
                    :value="editMyFavoriteBlock.youtuber"
                    @input="editMyFavoriteBlock.youtuber = $event.target.value"
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </v-card>
            </v-col>
            <v-col cols="12" sm="3">
              <v-card class="pa-2" height="130px" color="brown lighten-5">
                <label class="form-label-text-block">お笑い芸人</label>
                <ValidationProvider v-slot="{ errors }" rules="max_no_field:15">
                  <input
                    id="entertainer-form"
                    type="text"
                    class="input-form-text-block"
                    :value="editMyFavoriteBlock.entertainer"
                    @input="
                      editMyFavoriteBlock.entertainer = $event.target.value
                    "
                  />
                  <span class="text-red-400">{{ errors[0] }}</span>
                </ValidationProvider>
              </v-card>
            </v-col>
          </v-row>
          <div class="text-center mt-3">
            <v-btn
              id="update-my-favorite-block-button"
              type="submit"
              depressed
              elevation="4"
              x-large
              :disabled="invalid"
              color="teal lighten-3"
              class="white--text"
            >
              My Favorite ブロックを更新！
            </v-btn>
          </div>
        </form>
      </ValidationObserver>
    </v-container>
  </v-dialog>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";

export default {
  props: {
    isShownEditMyFavoriteFormatDialog: {
      type: Boolean,
      required: true,
    },
    editMyFavoriteBlock: {
      type: Object,
      required: true,
    },
  },

  methods: {
    patchMyFavoriteBlock: async function() {
      const res = await axios.patch(
        `/api/v1/my_favorite_blocks/${this.editMyFavoriteBlock.id}`,
        this.editMyFavoriteBlock
      );
      if (res.status !== 200) {
        process.exit();
      }
      return res.data;
    },
    hundleUpdateMyFavoriteBlock() {
      this.patchMyFavoriteBlock().then((result) => {
        this.$emit("update-my-favorite-block", result);
      });
      this.hundleCloseEditMyFavoriteFormatDialog();
    },
    hundleCloseEditMyFavoriteFormatDialog() {
      this.$emit("close-edit-my-favorite-format-dialog");
      requestAnimationFrame(() => {
        this.$refs.observer.reset();
      });
    },
  },
};
</script>

<style scoped>
.my-favorite-block-bg {
  background: linear-gradient(#ccc 0.1px, transparent 0.6px) #fffbf2;
  background-size: auto 2.5em;
  line-height: 2.5em;
  border-bottom: 1px solid #ccc;
  border-left: 1px solid #ccc;
  border-right: 1px solid #ccc;
  overflow: hidden;
}
</style>
