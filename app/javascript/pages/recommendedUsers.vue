<template>
  <div class="top">
    <div class="top-bg">
      <div>
        <v-row>
          <v-col cols="12" sm="12">
            <div class="text-center text-5xl">
              - - - - 共感したブロック一覧- - - -
            </div>
          </v-col>
        </v-row>
      </div>
    </div>
    <div class="p-20">
      <div class="top-sub-title m-5">クエスチョンブロック</div>
      <v-row>
        <v-col
          v-for="questionBlock in randomCurrentUserLikesQuestionBlocks"
          :key="questionBlock.id"
          cols="12"
          sm="4"
        >
          {{ questionBlock.owing_user.name }} さん
          <div class="border-2 border-gray-500"></div>
          <v-card
            class="rounded-2xl p-5 note-box"
            outlined
            color="red lighten-4"
          >
            <p class="text-2xl font-bold text-gray-600 px-3 py-3">
              {{ questionBlock.title }}
            </p>
            <template v-for="question_item in questionBlock.question_items">
              <div :key="question_item.id">
                <div class="rounded-lg">
                  <v-row>
                    <label for="question_item_content" class="mx-5 text-sm">
                      {{ question_item.content }}
                    </label>
                    <v-col cols="12" sm="12" class="mb-2">
                      <v-card class="p-2" outlined color="white">
                        {{ question_item.answer }}
                      </v-card>
                    </v-col>
                  </v-row>
                </div>
              </div>
            </template>
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
