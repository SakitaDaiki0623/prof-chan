<template>
  <div
    v-if="isBlocksZero"
    class="bg"
  >
    <v-row
      justify="center"
      align-content="center"
      class="border-2 border-brown-500 border-dashed"
    >
      <v-col
        cols="12"
        sm="8"
        align-self="center"
      >
        <div
          class="ext-4xl bordertext-xl text-center bg-brown-50 pa-10 ma-5 rounded-full md:t-brown-500 border-4 border-dashed"
        >
          <v-icon medium>
            mdi-star-box
          </v-icon>
          よくブックマークされるあなたのブロック
          <v-icon medium>
            mdi-star-box
          </v-icon>
          <div class="text-sm">
            よくブックマークされるブロックは共通の話題になりそう
          </div>
        </div>
      </v-col>
      <v-col
        cols="12"
        sm="4"
      >
        <img
          src="../../images/prof_open_happy.png"
          class="max-w-xs mx-auto"
        >
      </v-col>
    </v-row>

    <!-- Favorite Block -->
    <v-row
      v-if="favoriteBlock"
      class="bg-brown-100 border-2 border-brown-500 border-dashed"
      justify="center"
      align-content="center"
    >
      <v-col
        cols="12"
        md="5"
      >
        <FavoriteBlockCard
          :favorite-block="favoriteBlock"
        />
      </v-col>
      <v-col
        cols="12"
        md="5"
        class="pa-5"
        align-self="center"
      >
        <BookmarkUserList :block="favoriteBlock" />
      </v-col>
    </v-row>
    <!-- Question Block -->
    <v-row
      v-if="questionBlock"
      class="bg-brown-100 border-2 border-brown-500 border-dashed"
      justify="center"
      align-content="center"
    >
      <v-col
        cols="12"
        md="5"
      >
        <QuestionBlockCard
          :question-block="questionBlock"
        />
      </v-col>
      <v-col
        cols="12"
        md="5"
        class="pa-5"
        align-self="center"
      >
        <BookmarkUserList :block="questionBlock" />
      </v-col>
    </v-row>
    <!-- Ranking Block -->
    <v-row
      v-if="rankingBlock"
      class="bg-brown-100 border-2 border-brown-500 border-dashed"
      justify="center"
      align-content="center"
    >
      <v-col
        cols="12"
        md="5"
      >
        <RankingBlockCard
          :ranking-block="rankingBlock"
        />
      </v-col>
      <v-col
        cols="12"
        md="5"
        class="pa-5"
        align-self="center"
      >
        <BookmarkUserList :block="rankingBlock" />
      </v-col>
    </v-row>
    <!-- YesOrNo Block -->
    <v-row
      v-if="yesOrNoBlock"
      class="bg-brown-100 border-2 border-brown-500 border-dashed"
      justify="center"
      align-content="center"
    >
      <v-col
        cols="12"
        md="5"
      >
        <YesOrNoBlockCard
          :yes-or-no-block="yesOrNoBlock"
        />
      </v-col>
      <v-col
        cols="12"
        md="5"
        class="pa-5"
        align-self="center"
      >
        <BookmarkUserList :block="yesOrNoBlock" />
      </v-col>
    </v-row>
    <!-- Text Block -->
    <v-row
      v-if="textBlock"
      class="bg-brown-100 border-2 border-brown-500 border-dashed"
      justify="center"
      align-content="center"
    >
      <v-col
        cols="12"
        md="5"
      >
        <TextBlockCard :text-block="textBlock" />
      </v-col>
      <v-col
        cols="12"
        md="5"
        class="pa-5"
        align-self="center"
      >
        <BookmarkUserList :block="textBlock" />
      </v-col>
    </v-row>
  </div>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";
import FavoriteBlockCard from "../favorite_block/FavoriteBlockCard";
import QuestionBlockCard from "../question_block/QuestionBlockCard";
import RankingBlockCard from "../ranking_block/RankingBlockCard";
import YesOrNoBlockCard from "../yes_or_no_block/YesOrNoBlockCard";
import TextBlockCard from "../text_block/TextBlockCard";
import BookmarkUserList from "../parts/BookmarkUserList";

export default {
  components: {
    FavoriteBlockCard,
    QuestionBlockCard,
    RankingBlockCard,
    YesOrNoBlockCard,
    TextBlockCard,
    BookmarkUserList,
  },
  data() {
    return {
      favoriteBlock: {},
      questionBlock: {},
      rankingBlock: {},
      yesOrNoBlock: {},
      textBlock: {},
    };
  },
  computed: {
    ...mapState("users", ["currentUser"]),
    isBlocksZero() {
      return this.favoriteBlock == "" &&
        this.questionBlock == "" &&
        this.rankingBlock == "" &&
        this.yesOrNoBlock == "" &&
        this.textBlock == ""
        ? false
        : true;
    },
  },
  mounted() {
    this.firstRead();
  },

  methods: {
    async firstRead() {
      await this.fecthFavoriteBlock();
      await this.fecthQuestionBlock();
      await this.fecthRankingBlock();
      await this.fecthYesOrNoBlock();
      await this.fecthTextBlock();
    },
    async fecthFavoriteBlock() {
      await axios
        .get(`/api/v1/favorite_blocks/recommended_topic_block`)
        .then((res) => (this.favoriteBlock = res.data));
    },
    async fecthQuestionBlock() {
      await axios
        .get(`/api/v1/question_blocks/recommended_topic_block`)
        .then((res) => (this.questionBlock = res.data));
    },
    async fecthRankingBlock() {
      await axios
        .get(`/api/v1/ranking_blocks/recommended_topic_block`)
        .then((res) => (this.rankingBlock = res.data));
    },
    async fecthYesOrNoBlock() {
      await axios
        .get(`/api/v1/yes_or_no_blocks/recommended_topic_block`)
        .then((res) => (this.yesOrNoBlock = res.data));
    },
    async fecthTextBlock() {
      await axios
        .get(`/api/v1/text_blocks/recommended_topic_block`)
        .then((res) => (this.textBlock = res.data));
    },
    moveToUserProfilePage(profile) {
      this.$router.push(`/profiles/${profile.public_uid}`).catch((err) => {});
    },
  },
};
</script>

<style scoped>
.bg {
  color: rgb(77, 77, 77);
  background: #d7ccc8;
}

.top-bg {
  background-color: #efebe9;
  padding: 2rem;
}

.top-three-recommended-users-space {
  background-color: #b39e9e;
  padding: 2rem;
}
</style>

<style scoped>
.v-card {
  transition: transform 0.3s ease-in-out;
}

.v-card:not(.on-hover) {
  transform: scale(0.95);
}
</style>
