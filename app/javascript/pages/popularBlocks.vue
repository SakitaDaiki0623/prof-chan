<template>
  <div>
    <Loading v-show="loading"></Loading>
    <div class="top" v-show="!loading">
      <div v-if="isThereAnyBlock">
        <div class="top-bg mb-16">
          <div>
            <v-row>
              <v-col cols="12" sm="12">
                <div class="text-center text-2xl md:text-4xl">
                  - - - - 社内で人気のブロック- - - -
                </div>
              </v-col>
            </v-row>
          </div>
        </div>
        <!-- Favorite ブロック -->
        <div
          class="py-10 sm:px-16 bg-brown-400 mb-16"
          v-if="favoritePopularBlocksTopThree.length !== 0"
        >
          <v-row>
            <v-col cols="12" sm="11">
              <div
                class="text-center text-4xl text-white pa-5 border-class font-bold"
              >
                Favorite ブロック
              </div>
            </v-col>
            <v-col cols="12" sm="1" class="sm:mb-16">
              <img src="../images/prof_normal.png" class="image mx-auto" />
            </v-col>
            <v-col
              v-for="favoriteBlock in favoritePopularBlocksTopThree"
              :key="favoriteBlock.id"
              cols="12"
              md="4"
              class="border-2 border-white border-dashed"
            >
              <div class="bg-white pa-1 inline-block">
                {{ favoriteBlock.owing_user.name }}
              </div>
              <v-img
                max-width="50px"
                :src="favoriteBlock.owing_user.image.url"
                class="inline"
              ></v-img>
              <FavoriteBlockCard :favorite-block="favoriteBlock" />
            </v-col>
          </v-row>
        </div>
        <!-- /Favorite ブロック -->

        <!-- クエスチョンブロック -->
        <div
          class="py-10 sm:px-16 bg-brown-300 mb-16"
          v-if="questionPopularBlocksTopThree.length !== 0"
        >
          <v-row>
            <v-col cols="12" sm="11">
              <div
                class="text-center text-4xl text-white pa-5 border-class font-bold"
              >
                クエスチョンブロック
              </div>
            </v-col>
            <v-col cols="12" sm="1" class="sm:mb-16">
              <img src="../images/prof_happy.png" class="image mx-auto" />
            </v-col>
            <v-col
              v-for="questionBlock in questionPopularBlocksTopThree"
              :key="questionBlock.id"
              cols="12"
              md="6"
              lg="4"
              class="border-2 border-white border-dashed"
            >
              <div class="bg-white pa-1 inline-block">
                {{ questionBlock.owing_user.name }}
              </div>
              <v-img
                max-width="50px"
                :src="questionBlock.owing_user.image.url"
                class="inline"
              ></v-img>
              <QuestionBlockCard :question-block="questionBlock" />
            </v-col>
          </v-row>
        </div>
        <!-- /クエスチョンブロック -->

        <!-- ランキングブロック -->
        <div
          class="py-10 sm:px-16 bg-brown-400 mb-16"
          v-if="rankingPopularBlocksTopThree.length !== 0"
        >
          <v-row>
            <v-col cols="12" sm="11">
              <div
                class="text-center text-4xl text-white pa-5 border-class font-bold"
              >
                ランキングブロック
              </div>
            </v-col>
            <v-col cols="12" sm="1" class="sm:mb-16">
              <img src="../images/prof_open_normal.png" class="image mx-auto" />
            </v-col>
            <v-col
              v-for="rankingBlock in rankingPopularBlocksTopThree"
              :key="rankingBlock.id"
              cols="12"
              md="6"
              lg="4"
              class="border-2 border-white border-dashed"
            >
              <div class="bg-white pa-1 inline-block">
                {{ rankingBlock.owing_user.name }}
              </div>
              <v-img
                max-width="50px"
                :src="rankingBlock.owing_user.image.url"
                class="inline"
              ></v-img>
              <RankingBlockCard :ranking-block="rankingBlock" />
            </v-col>
          </v-row>
        </div>
        <!-- /ランキングブロック -->

        <!-- Yes or No ブロック -->
        <div
          class="py-10 sm:px-16 bg-brown-300 mb-16"
          v-if="yesOrNoPopularBlocksTopThree.length !== 0"
        >
          <v-row>
            <v-col cols="12" sm="11">
              <div
                class="text-center text-4xl text-white pa-5 border-class font-bold"
              >
                Yes or No ブロック
              </div>
            </v-col>
            <v-col cols="12" sm="1" class="sm:mb-16">
              <img src="../images/prof_open_happy.png" class="image mx-auto" />
            </v-col>
            <v-col
              v-for="yesOrNoBlock in yesOrNoPopularBlocksTopThree"
              :key="yesOrNoBlock.id"
              cols="12"
              md="6"
              lg="4"
              class="border-2 border-white border-dashed"
            >
              <div class="bg-white pa-1 inline-block">
                {{ yesOrNoBlock.owing_user.name }}
              </div>
              <v-img
                max-width="50px"
                :src="yesOrNoBlock.owing_user.image.url"
                class="inline"
              ></v-img>
              <YesOrNoBlockCard :yes-or-no-block="yesOrNoBlock" />
            </v-col>
          </v-row>
        </div>
        <!-- /Yes or No ブロック -->

        <!-- テキストブロック -->
        <div
          class="py-10 sm:px-16 bg-brown-400 mb-16"
          v-if="textPopularBlocksTopThree.length !== 0"
        >
          <v-row>
            <v-col cols="12" sm="11">
              <div
                class="text-center text-4xl text-white pa-5  border-class font-bold"
              >
                テキストブロック
              </div>
            </v-col>
            <v-col cols="12" sm="1" class="sm:mb-16">
              <img src="../images/prof_normal.png" class="image mx-auto" />
            </v-col>
            <v-col
              v-for="textBlock in textPopularBlocksTopThree"
              :key="textBlock.id"
              cols="12"
              md="6"
              lg="4"
              class="border-2 border-white border-dashed"
            >
              <div class="bg-white pa-1 inline-block">
                {{ textBlock.owing_user.name }}
              </div>
              <v-img
                max-width="50px"
                :src="textBlock.owing_user.image.url"
                class="inline"
              ></v-img>
              <TextBlockCard :text-block="textBlock" />
            </v-col>
          </v-row>
        </div>
        <!-- /テキストブロック -->
        <ToTopButton />
      </div>
      <div v-else>
        <NotAnyBookmarkBlock prof-message="まだブロックが作成されていないよ" />
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import TextBlockCard from "../components/text_block/TextBlockCard";
import QuestionBlockCard from "../components/question_block/QuestionBlockCard";
import YesOrNoBlockCard from "../components/yes_or_no_block/YesOrNoBlockCard";
import RankingBlockCard from "../components/ranking_block/RankingBlockCard";
import FavoriteBlockCard from "../components/favorite_block/FavoriteBlockCard";
import NotAnyBookmarkBlock from "../components/NotAnyBookmarkBlock";
import Loading from "../components/shared/Loading";
import ToTopButton from "../components/parts/ToTopButton";

export default {
  components: {
    TextBlockCard,
    QuestionBlockCard,
    YesOrNoBlockCard,
    RankingBlockCard,
    FavoriteBlockCard,
    NotAnyBookmarkBlock,
    Loading,
    ToTopButton,
  },
  data() {
    return {
      recentlyJoinedUserProfiles: [],
      favoritePopularBlocks: [],
      questionPopularBlocks: [],
      rankingPopularBlocks: [],
      yesOrNoPopularBlocks: [],
      textPopularBlocks: [],
      visible: false,
      loading: true,
    };
  },
  computed: {
    isThereAnyBlock() {
      if (
        this.favoritePopularBlocksTopThree.length == 0 &&
        this.questionPopularBlocksTopThree.length == 0 &&
        this.rankingPopularBlocksTopThree.length == 0 &&
        this.yesOrNoPopularBlocksTopThree.length == 0 &&
        this.textPopularBlocksTopThree.length == 0
      ) {
        return false;
      } else {
        return true;
      }
    },
    favoritePopularBlocksFirstPlace() {
      return this.favoritePopularBlocksTopThree[0];
    },
    favoritePopularBlocksSecondPlace() {
      return this.favoritePopularBlocksTopThree[1];
    },
    favoritePopularBlocksThirdPlace() {
      return this.favoritePopularBlocksTopThree[2];
    },
    favoritePopularBlocksTopThree() {
      return this.favoritePopularBlocks.splice(0, 3);
    },
    questionPopularBlocksFirstPlace() {
      return this.questionPopularBlocksTopThree[0];
    },
    questionPopularBlocksSecondPlace() {
      return this.questionPopularBlocksTopThree[1];
    },
    questionPopularBlocksThirdPlace() {
      return this.questionPopularBlocksTopThree[2];
    },
    questionPopularBlocksTopThree() {
      return this.questionPopularBlocks.splice(0, 3);
    },
    rankingPopularBlocksFirstPlace() {
      return this.rankingPopularBlocksTopThree[0];
    },
    rankingPopularBlocksSecondPlace() {
      return this.rankingPopularBlocksTopThree[1];
    },
    rankingPopularBlocksThirdPlace() {
      return this.rankingPopularBlocksTopThree[2];
    },
    rankingPopularBlocksTopThree() {
      return this.rankingPopularBlocks.splice(0, 3);
    },
    yesOrNoPopularBlocksFirstPlace() {
      return this.yesOrNoPopularBlocksTopThree[0];
    },
    yesOrNoPopularBlocksSecondPlace() {
      return this.yesOrNoPopularBlocksTopThree[1];
    },
    yesOrNoPopularBlocksThirdPlace() {
      return this.yesOrNoPopularBlocksTopThree[2];
    },
    yesOrNoPopularBlocksTopThree() {
      return this.yesOrNoPopularBlocks.splice(0, 3);
    },
    textPopularBlocksFirstPlace() {
      return this.textPopularBlocksTopThree[0];
    },
    textPopularBlocksSecondPlace() {
      return this.textPopularBlocksTopThree[1];
    },
    textPopularBlocksThirdPlace() {
      return this.textPopularBlocksTopThree[2];
    },
    textPopularBlocksTopThree() {
      return this.textPopularBlocks.splice(0, 3);
    },
  },
  mounted() {
    setTimeout(() => {
      this.loading = false;
    }, 1000);
    this.firstRead();
  },
  created() {
    window.addEventListener("scroll", this.handleScroll);
  },
  destroyed() {
    window.removeEventListener("scroll", this.handleScroll);
  },
  methods: {
    handleScroll() {
      if (!this.visible) {
        var top = this.$el.getBoundingClientRect().top;
        this.visible = top < window.innerHeight + 100;
      }
    },
    async firstRead() {
      await this.fetchRecentlyJoinedUserProfiles();
      await this.fetchFavoritePopularBlocks();
      await this.fetchQuestionPopularBlocks();
      await this.fetchRankingPopularBlocks();
      await this.fetchYesOrNoPopularBlocks();
      await this.fetchTextPopularBlocks();
    },

    async fetchRecentlyJoinedUserProfiles() {
      await axios
        .get("/api/v1/profiles/recently_joined_user_profiles")
        .then((res) => (this.recentlyJoinedUserProfiles = res.data));
    },
    async fetchFavoritePopularBlocks() {
      await axios
        .get("/api/v1/favorite_blocks/popular_blocks")
        .then((res) => (this.favoritePopularBlocks = res.data));
    },
    async fetchQuestionPopularBlocks() {
      await axios
        .get("/api/v1/question_blocks/popular_blocks")
        .then((res) => (this.questionPopularBlocks = res.data));
    },
    async fetchRankingPopularBlocks() {
      await axios
        .get("/api/v1/ranking_blocks/popular_blocks")
        .then((res) => (this.rankingPopularBlocks = res.data));
    },
    async fetchYesOrNoPopularBlocks() {
      await axios
        .get("/api/v1/yes_or_no_blocks/popular_blocks")
        .then((res) => (this.yesOrNoPopularBlocks = res.data));
    },
    async fetchTextPopularBlocks() {
      await axios
        .get("/api/v1/text_blocks/popular_blocks")
        .then((res) => (this.textPopularBlocks = res.data));
    },
  },
  created() {
    document.title = `人気ブロック - プロフちゃん`;
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

.image {
  max-width: 5rem;
}

.border-class {
  background-image: url("data:image/svg+xml,%3csvg width='100%25' height='100%25' xmlns='http://www.w3.org/2000/svg'%3e%3crect width='100%25' height='100%25' fill='none' stroke='white' stroke-width='10' stroke-dasharray='22%2c 22' stroke-dashoffset='0' stroke-linecap='square'/%3e%3c/svg%3e");
}
</style>
