<template>
  <div class="top">
    <div class="top-bg">
      <div>
        <v-row>
          <v-col cols="12" sm="12">
            <div class="text-center text-5xl">
              - - - - あなたが興味のある社員- - - -
            </div>
          </v-col>
        </v-row>
      </div>
    </div>
    <div class="p-10">
      <div class="top-sub-title m-5">クエスチョンブロック</div>
      <v-row>
        <v-col
          v-for="questionBlock in randomCurrentUserLikesQuestionBlocks"
          :key="questionBlock.id"
        >
          <v-card
            class="mx-auto"
            max-width="344"
            outlined
            color="red lighten-4"
          >
            <v-img :src="questionBlock.owing_user.image" height="180px" />

            <div class="text-center font-bold text-3xl pt-5 text-brown-600">
              {{ questionBlock.owing_user.name }} さん
            </div>
          </v-card>
          <v-card
            class="mx-auto m-5"
            max-width="344"
            outlined
            color="brown lighten-4"
          >
            話題: {{ questionBlock.title }}
            <div v-for="item in questionBlock.question_items" :key="item.id">
              {{ item.content }}と質問されたら、{{ item.answer }}と答えるよ
            </div>
          </v-card>
        </v-col>
      </v-row>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      datas: [],
      randomCurrentUserLikesQuestionBlocks: [],
      randomCurrentUserLikesRankingBlocks: [],
      randomCurrentUserLikesYesOrNoBlocks: [],
      randomCurrentUserLikesTextBlocks: [],
    };
  },
  mounted() {
    this.firstRead();
  },
  methods: {
    async firstRead() {
      await this.fecthRandomCurrentUserLikesQuestionBlocks();
      await this.fecthRandomCurrentUserLikesRankingBlocks();
      await this.fecthRandomCurrentUserLikesYesOrNoBlocks();
      await this.fecthRandomCurrentUserLikesTextBlocks();
    },
    async fecthRandomCurrentUserLikesQuestionBlocks() {
      await axios
        .get("/api/v1/question_blocks/random_current_user_likes_blocks")
        .then((res) => (this.randomCurrentUserLikesQuestionBlocks = res.data));
    },
    async fecthRandomCurrentUserLikesRankingBlocks() {
      await axios
        .get("/api/v1/ranking_blocks/random_current_user_likes_blocks")
        .then((res) => (this.randomCurrentUserLikesRankingBlocks = res.data));
    },
    async fecthRandomCurrentUserLikesYesOrNoBlocks() {
      await axios
        .get("/api/v1/yes_or_no_blocks/random_current_user_likes_blocks")
        .then((res) => (this.randomCurrentUserLikesYesOrNoBlocks = res.data));
    },
    async fecthRandomCurrentUserLikesTextBlocks() {
      await axios
        .get("/api/v1/text_blocks/random_current_user_likes_blocks")
        .then((res) => (this.randomCurrentUserLikesTextBlocks = res.data));
    },
  },
};
</script>

<style scoped>
.top {
  color: rgb(77, 77, 77);
}

.top-bg {
  background-color: #efebe9;
  padding: 2rem;
}
</style>
