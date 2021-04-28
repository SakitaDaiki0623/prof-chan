<template>
  <v-container class="my-favorite-block-bg mb-10">
    <v-row justify="end" v-show="isThisEditPage">
      <v-btn
        id="edit-my-favorite-block-button"
        tile
        small
        color="teal lighten-4"
        @click="openEditMyFavoriteFormatDialog"
      >
        <v-icon> mdi-pencil </v-icon>
      </v-btn>
    </v-row>
    <p class="font-weight-bold text-4xl text-gray-600 text-center">
      My Favorites コーナー
    </p>
    <v-row class="mt-6" no-gutters>
      <v-col cols="12" sm="3" v-show="myFavoriteBlock.manga_anime">
        <v-card class="pa-2" height="100" color="brown lighten-5">
          <label class="form-label-text-block">漫画・アニメ</label>
          <p class="my-favorite-block-index">
            {{ myFavoriteBlock.manga_anime }}
          </p>
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" v-show="myFavoriteBlock.game_app">
        <v-card class="pa-2" height="100" color="brown lighten-5">
          <label class="form-label-text-block">ゲーム・アプリ</label>
          <p class="my-favorite-block-index">{{ myFavoriteBlock.game_app }}</p>
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" v-show="myFavoriteBlock.character">
        <v-card class="pa-2" height="100" color="brown lighten-5">
          <label class="form-label-text-block">キャラクター</label>
          <p class="my-favorite-block-index">{{ myFavoriteBlock.character }}</p>
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" v-show="myFavoriteBlock.actor">
        <v-card class="pa-2" height="100" color="brown lighten-5">
          <label class="form-label-text-block">俳優・女優</label>
          <p class="my-favorite-block-index">{{ myFavoriteBlock.actor }}</p>
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" v-show="myFavoriteBlock.music">
        <v-card class="pa-2" height="100" color="brown lighten-5">
          <label class="form-label-text-block">音楽</label>
          <p class="my-favorite-block-index">{{ myFavoriteBlock.music }}</p>
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" v-show="myFavoriteBlock.food">
        <v-card class="pa-2" height="100" color="brown lighten-5">
          <label class="form-label-text-block">食べ物</label>
          <p class="my-favorite-block-index">{{ myFavoriteBlock.food }}</p>
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" v-show="myFavoriteBlock.animal">
        <v-card class="pa-2" height="100" color="brown lighten-5">
          <label class="form-label-text-block">動物</label>
          <p class="my-favorite-block-index">{{ myFavoriteBlock.animal }}</p>
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" v-show="myFavoriteBlock.sports">
        <v-card class="pa-2" height="100" color="brown lighten-5">
          <label class="form-label-text-block">スポーツ</label>
          <p class="my-favorite-block-index">{{ myFavoriteBlock.sports }}</p>
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" v-show="myFavoriteBlock.book">
        <v-card class="pa-2" height="100" color="brown lighten-5">
          <label class="form-label-text-block">本</label>
          <p class="my-favorite-block-index">{{ myFavoriteBlock.book }}</p>
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" v-show="myFavoriteBlock.place">
        <v-card class="pa-2" height="100" color="brown lighten-5">
          <label class="form-label-text-block">場所</label>
          <p class="my-favorite-block-index">{{ myFavoriteBlock.place }}</p>
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" v-show="myFavoriteBlock.snack">
        <v-card class="pa-2" height="100" color="brown lighten-5">
          <label class="form-label-text-block">お菓子</label>
          <p class="my-favorite-block-index">{{ myFavoriteBlock.snack }}</p>
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" v-show="myFavoriteBlock.alcohol_drink">
        <v-card class="pa-2" height="100" color="brown lighten-5">
          <label class="form-label-text-block">お酒</label>
          <p class="my-favorite-block-index">
            {{ myFavoriteBlock.alcohol_drink }}
          </p>
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" v-show="myFavoriteBlock.restaurants">
        <v-card class="pa-2" height="100" color="brown lighten-5">
          <label class="form-label-text-block">飲食店</label>
          <p class="my-favorite-block-index">
            {{ myFavoriteBlock.restaurants }}
          </p>
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" v-show="myFavoriteBlock.musician">
        <v-card class="pa-2" height="100" color="brown lighten-5">
          <label class="form-label-text-block">歌手</label>
          <p class="my-favorite-block-index">{{ myFavoriteBlock.musician }}</p>
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" v-show="myFavoriteBlock.youtuber">
        <v-card class="pa-2" height="100" color="brown lighten-5">
          <label class="form-label-text-block">YouTuber</label>
          <p class="my-favorite-block-index">{{ myFavoriteBlock.youtuber }}</p>
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" v-show="myFavoriteBlock.entertainer">
        <v-card class="pa-2" height="100" color="brown lighten-5">
          <label class="form-label-text-block">お笑い芸人</label>
          <p class="my-favorite-block-index">
            {{ myFavoriteBlock.entertainer }}
          </p>
        </v-card>
      </v-col>
    </v-row>
    <EditMyFavoriteBlockDialog
      :is-shown-edit-my-favorite-format-dialog="
        isShownEditMyFavoriteFormatDialog
      "
      :edit-my-favorite-block="editMyFavoriteBlock"
      @close-edit-my-favorite-format-dialog="closeEditMyFavoriteFormatDialog"
      @update-my-favorite-block="updateMyFavoriteBlock"
    />
  </v-container>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";

import EditMyFavoriteBlockDialog from "./EditMyFavoriteBlockDialog";

export default {
  components: {
    EditMyFavoriteBlockDialog,
  },
  props: {
    isThisEditPage: {
      type: Boolean,
      required: false,
      default: false,
    },
  },
  data() {
    return {
      myFavoriteBlock: {},
      editMyFavoriteBlock: {},
      isShownEditMyFavoriteFormatDialog: false,
    };
  },
  computed: {
    ...mapState("users", ["currentUser"]),
  },
  created() {
    this.fetchMyFavoriteBlock().then((result) => {
      const res = result.find(
        (myFavoriteBlock) =>
          myFavoriteBlock.profile_block.id == this.currentUser.profile_block.id
      );
      this.myFavoriteBlock = res;
    });
  },
  methods: {
    fetchMyFavoriteBlock: async function() {
      const res = await axios.get("/api/v1/my_favorite_blocks");
      if (res.status !== 200) {
        process.exit();
      }
      return res.data;
    },
    updateMyFavoriteBlock(result) {
      this.myFavoriteBlock = result;
    },
    openEditMyFavoriteFormatDialog() {
      this.editMyFavoriteBlock = Object.assign({}, this.myFavoriteBlock);
      this.isShownEditMyFavoriteFormatDialog = true;
    },
    closeEditMyFavoriteFormatDialog() {
      this.isShownEditMyFavoriteFormatDialog = false;
    },
  },
};
</script>

<style scoped>
.my-favorite-block-bg {
  background-image: linear-gradient(
    -45deg,
    #fff 25%,
    #eac7cd 25%,
    #eac7cd 50%,
    #fff 50%,
    #fff 75%,
    #eac7cd 75%,
    #eac7cd
  );
}
</style>
