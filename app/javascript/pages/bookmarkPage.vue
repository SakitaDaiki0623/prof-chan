<template>
  <div>
    <Loading v-show="loading"></Loading>
    <div class="top" v-show="!loading">
      <div class="top-three-recommended-users-space" v-if="firstPlaceUserExist">
        <div
          class="text-xl top-sub-title mb-5 lg:text-4xl lg:mb-10 text-center"
        >
          <v-icon color="white" large>mdi-crown-outline</v-icon>
          あなたがよくブックマークする社員TOP3
          <v-icon color="white" large>mdi-crown-outline</v-icon>
        </div>

        <!-- モバイル用 -->
        <div v-if="isMdAndDown">
          <v-row class="py-5" justify="center">
            <v-col
              align-self="start"
              align="center"
              cols="12"
              lg="3"
              class="border-2 border-white border-dashed ma-5"
            >
              <div class="place-text">第1位</div>
              <ProfCard
                :user="firstPlaceUser"
                :is-this-edit-page="false"
              /> </v-col
            ><v-col
              align-self="center"
              align="center"
              cols="12"
              lg="3"
              class="border-2 border-white border-dashed ma-5"
            >
              <div class="place-text">第2位</div>
              <div v-if="secondPlaceUserExist">
                <ProfCard :user="secondPlaceUser" :is-this-edit-page="false" />
              </div>

              <PlaceDoesNotExistCard place-number="2" v-else />
            </v-col>
            <v-col
              align-self="end"
              align="center"
              cols="12"
              lg="3"
              class="border-2 border-white border-dashed ma-5"
            >
              <div class="place-text">第3位</div>
              <div v-if="thirdPlaceUserExist">
                <ProfCard :user="thirdPlaceUser" :is-this-edit-page="false" />
              </div>
              <PlaceDoesNotExistCard v-else place-number="3" />
            </v-col>
          </v-row>
        </div>

        <!-- 画面サイズlg以上 -->
        <div v-else>
          <v-row class="py-5" justify="center" style="height: 40rem">
            <v-col
              align-self="center"
              align="center"
              cols="12"
              sm="3"
              class="border-2 border-white border-dashed ma-5"
            >
              <div class="place-text">第2位</div>
              <div v-if="secondPlaceUserExist">
                <ProfCard :user="secondPlaceUser" :is-this-edit-page="false" />
              </div>

              <PlaceDoesNotExistCard place-number="2" v-else />
            </v-col>
            <v-col
              align-self="start"
              align="center"
              cols="12"
              sm="3"
              class="border-2 border-white border-dashed ma-5"
            >
              <div class="place-text">第1位</div>
              <ProfCard :user="firstPlaceUser" :is-this-edit-page="false" />
            </v-col>
            <v-col
              align-self="end"
              align="center"
              cols="12"
              sm="3"
              class="border-2 border-white border-dashed ma-5"
            >
              <div class="place-text">第3位</div>
              <div v-if="thirdPlaceUserExist">
                <ProfCard :user="thirdPlaceUser" :is-this-edit-page="false" />
              </div>
              <PlaceDoesNotExistCard v-else place-number="3" />
            </v-col>
          </v-row>
        </div>
      </div>

      <div v-if="firstPlaceUserExist">
        <div class="top-bg">
          <v-row>
            <v-col cols="12" sm="12">
              <div class="text-center text-2xl md:text-4xl">
                - - - - ブックマーク一覧- - - -
              </div>
            </v-col>
          </v-row>
        </div>

        <div class="md:pa-16">
          <div
            v-if="randomCurrentUserLikesFavoriteBlocks.length !== 0"
            class="mb-10"
          >
            <v-card color="brown lighten-2" class="pa-10">
              <div class="top-sub-title ma-5 text-center text-2xl md:text-4xl">
                Favorite ブロック
              </div>
              <div class="text-center">
                <v-pagination
                  v-model="favoriteBlockPage"
                  :length="favoriteBlocklength"
                  circle
                  @input="favoriteBlockPageChange"
                  color="brown lighten-2"
                  class="mb-10"
                ></v-pagination>
              </div>
              <v-row>
                <v-col
                  v-for="favoriteBlock in displayFavoriteBlocks"
                  :key="favoriteBlock.id"
                  cols="12"
                  sm="6"
                  md="4"
                  lg="3"
                  class="border-2 border-white border-dashed"
                >
                  <div>
                    <div class="bg-white inline-block">
                      {{ favoriteBlock.owing_user.name }} さん
                    </div>
                    <v-img
                      max-width="50px"
                      :src="favoriteBlock.owing_user.image.url"
                      class="inline"
                    ></v-img>
                  </div>
                  <FavoriteBlockCard :favorite-block="favoriteBlock" />
                </v-col>
              </v-row>
            </v-card>
          </div>

          <div
            v-if="randomCurrentUserLikesQuestionBlocks.length !== 0"
            class="mb-10"
          >
            <v-card color="brown lighten-2" class="pa-10">
              <div class="top-sub-title ma-5 text-center text-2xl md:text-4xl">
                クエスチョンブロック
              </div>
              <div class="text-center">
                <v-pagination
                  v-model="questionBlockPage"
                  :length="questionBlocklength"
                  circle
                  @input="questionBlockPageChange"
                  color="red lighten-3"
                  class="mb-10"
                ></v-pagination>
              </div>
              <v-row>
                <v-col
                  v-for="questionBlock in displayQuestionBlocks"
                  :key="questionBlock.id"
                  cols="12"
                  md="6"
                  lg="4"
                  class="border-2 border-white border-dashed"
                >
                  <div>
                    <div class="bg-white inline-block">
                      {{ questionBlock.owing_user.name }} さん
                    </div>
                    <v-img
                      max-width="50px"
                      :src="questionBlock.owing_user.image.url"
                      class="inline"
                    ></v-img>
                  </div>
                  <QuestionBlockCard :question-block="questionBlock" />
                </v-col>
              </v-row>
            </v-card>
          </div>

          <div
            v-if="randomCurrentUserLikesRankingBlocks.length !== 0"
            class="mb-10"
          >
            <v-card color="brown lighten-2" class="pa-10">
              <div class="top-sub-title ma-5 text-center text-2xl md:text-4xl">
                ランキングブロック
              </div>
              <div class="text-center">
                <v-pagination
                  v-model="rankingBlockPage"
                  :length="rankingBlocklength"
                  circle
                  @input="rankingBlockPageChange"
                  color="green lighten-3"
                  class="mb-10"
                ></v-pagination>
              </div>
              <v-row>
                <v-col
                  v-for="rankingBlock in displayRankingBlocks"
                  :key="rankingBlock.id"
                  cols="12"
                  md="6"
                  lg="4"
                  class="border-2 border-white border-dashed"
                >
                  <div>
                    <div class="bg-white inline-block">
                      {{ rankingBlock.owing_user.name }} さん
                    </div>
                    <v-img
                      max-width="50px"
                      :src="rankingBlock.owing_user.image.url"
                      class="inline"
                    ></v-img>
                  </div>
                  <RankingBlockCard :ranking-block="rankingBlock" />
                </v-col>
              </v-row>
            </v-card>
          </div>

          <div
            v-if="randomCurrentUserLikesYesOrNoBlocks.length !== 0"
            class="mb-10"
          >
            <v-card color="brown lighten-2" class="pa-10">
              <div class="top-sub-title ma-5 text-center text-2xl md:text-4xl">
                Yes or No ブロック
              </div>
              <div class="text-center">
                <v-pagination
                  v-model="yesOrNoBlockPage"
                  :length="yesOrNoBlocklength"
                  circle
                  @input="yesOrNoBlockPageChange"
                  color="orange lighten-3"
                  class="mb-10"
                ></v-pagination>
              </div>

              <v-row>
                <v-col
                  v-for="yesOrNoBlock in displayYesOrNoBlocks"
                  :key="yesOrNoBlock.id"
                  cols="12"
                  md="6"
                  lg="4"
                  class="border-2 border-white border-dashed"
                >
                  <div>
                    <div class="bg-white inline-block">
                      {{ yesOrNoBlock.owing_user.name }} さん
                    </div>
                    <v-img
                      max-width="50px"
                      :src="yesOrNoBlock.owing_user.image.url"
                      class="inline"
                    ></v-img>
                  </div>
                  <YesOrNoBlockCard :yes-or-no-block="yesOrNoBlock" />
                </v-col>
              </v-row>
            </v-card>
          </div>

          <div v-if="randomCurrentUserLikesTextBlocks.length !== 0">
            <v-card color="brown lighten-2" class="pa-10">
              <div class="top-sub-title my-10 text-center text-2xl md:text-4xl">
                テキストブロック
              </div>
              <div class="text-center">
                <v-pagination
                  v-model="textBlockPage"
                  :length="textBlocklength"
                  circle
                  @input="textBlockPageChange"
                  color="cyan lighten-3"
                  class="mb-10"
                ></v-pagination>
              </div>
              <transition-group tag="v-row" appear>
                <v-col
                  v-for="textBlock in displayTextBlocks"
                  :key="textBlock.id"
                  cols="12"
                  lg="6"
                  class="border-2 border-white border-dashed"
                >
                  <div>
                    <div class="bg-white inline-block">
                      {{ textBlock.owing_user.name }} さん
                    </div>
                    <v-img
                      max-width="50px"
                      :src="textBlock.owing_user.image.url"
                      class="inline"
                    ></v-img>
                  </div>
                  <TextBlockCard :text-block="textBlock" />
                </v-col>
              </transition-group>
            </v-card>
          </div>
        </div>
      </div>
      <NotAnyBookmarkBlock v-else />
      <div class="ma-16">
        <v-row>
          <v-spacer></v-spacer>
          <v-btn
            v-scroll-to="toTop"
            color="brown"
            x-large
            fab
            class="white--text"
            ><v-icon>mdi-arrow-up</v-icon></v-btn
          >
        </v-row>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import NotAnyBookmarkBlock from "../components/NotAnyBookmarkBlock";
import TextBlockCard from "../components/text_block/TextBlockCard";
import QuestionBlockCard from "../components/question_block/QuestionBlockCard";
import YesOrNoBlockCard from "../components/yes_or_no_block/YesOrNoBlockCard";
import RankingBlockCard from "../components/ranking_block/RankingBlockCard";
import FavoriteBlockCard from "../components/favorite_block/FavoriteBlockCard";
import PlaceDoesNotExistCard from "../components/static/PlaceDoesNotExistCard";
import ProfCard from "../components/ProfCard";
import Loading from "../components/shared/Loading";

export default {
  components: {
    NotAnyBookmarkBlock,
    TextBlockCard,
    QuestionBlockCard,
    YesOrNoBlockCard,
    RankingBlockCard,
    PlaceDoesNotExistCard,
    FavoriteBlockCard,
    ProfCard,
    Loading,
  },
  data() {
    return {
      loading: true,
      datas: [],
      randomCurrentUserLikesFavoriteBlocks: [],
      randomCurrentUserLikesQuestionBlocks: [],
      randomCurrentUserLikesRankingBlocks: [],
      randomCurrentUserLikesYesOrNoBlocks: [],
      randomCurrentUserLikesTextBlocks: [],
      firstPlaceUser: {},
      secondPlaceUser: {},
      thirdPlaceUser: {},

      // Favorite Blocks
      favoriteBlockPage: 1,
      displayFavoriteBlocks: [],
      favoriteBlockPageSize: 12,
      favoriteBlocklength: 0,
      // Question Blocks
      questionBlockPage: 1,
      displayQuestionBlocks: [],
      questionBlockPageSize: 6,
      questionBlocklength: 0,
      // Ranking Blocks
      rankingBlockPage: 1,
      displayRankingBlocks: [],
      rankingBlockPageSize: 6,
      rankingBlocklength: 0,
      // YesOrNo Blocks
      yesOrNoBlockPage: 1,
      displayYesOrNoBlocks: [],
      yesOrNoBlockPageSize: 6,
      yesOrNoBlocklength: 0,
      // Text Blocks
      textBlockPage: 1,
      displayTextBlocks: [],
      textBlockPageSize: 4,
      textBlocklength: 0,

      toTop: "#top",
    };
  },
  computed: {
    isMdAndDown() {
      return this.$vuetify.breakpoint.mdAndDown;
    },

    firstPlaceUserExist() {
      return !!Object.keys(this.firstPlaceUser).length;
    },
    secondPlaceUserExist() {
      return !!Object.keys(this.secondPlaceUser).length;
    },
    thirdPlaceUserExist() {
      return !!Object.keys(this.thirdPlaceUser).length;
    },
    getLikingBlocksOwingUserIds() {
      const allUserIds = this.questionLikedUserIds.concat(
        this.rankingLikedUserIds,
        this.yesOrNoLikedUserIds,
        this.textLikedUserIds,
        this.favoriteLikedUserIds
      );

      // 要素数が多いユーザートップ3のidを取得
      const dict = {};

      for (let key of allUserIds) {
        dict[key] = allUserIds.filter(function(x) {
          return x == key;
        }).length;
      }

      let arr = Object.keys(dict).map((e) => ({ user_id: e, value: dict[e] }));

      arr.sort(function(a, b) {
        if (a.value < b.value) return 1;
        if (a.value > b.value) return -1;
        return 0;
      });

      const topThreeUserIdAndLikesCount = arr.splice(0, 3);
      return topThreeUserIdAndLikesCount; // ex.0: {user_id: "2", value: 12}, 1: {user_id: "3", value: 6}, 2: {user_id: "1", value: 3}
    },
    favoriteLikedUserIds() {
      return this.randomCurrentUserLikesFavoriteBlocks.map(
        (value) => value.owing_user.id
      );
    },
    questionLikedUserIds() {
      return this.randomCurrentUserLikesQuestionBlocks.map(
        (value) => value.owing_user.id
      );
    },
    rankingLikedUserIds() {
      return this.randomCurrentUserLikesRankingBlocks.map(
        (value) => value.owing_user.id
      );
    },
    yesOrNoLikedUserIds() {
      return this.randomCurrentUserLikesYesOrNoBlocks.map(
        (value) => value.owing_user.id
      );
    },
    textLikedUserIds() {
      return this.randomCurrentUserLikesTextBlocks.map(
        (value) => value.owing_user.id
      );
    },
  },
  mounted() {
    setTimeout(() => {
      this.loading = false;
    }, 1000);
    this.firstRead();
  },
  created() {
    document.title = `ブックマーク一覧 - プロフちゃん`;
  },
  methods: {
    async firstRead() {
      await this.fecthRandomCurrentUserLikesFavoriteBlocks();
      await this.fecthRandomCurrentUserLikesQuestionBlocks();
      await this.fecthRandomCurrentUserLikesRankingBlocks();
      await this.fecthRandomCurrentUserLikesYesOrNoBlocks();
      await this.fecthRandomCurrentUserLikesTextBlocks();
      await this.fecthFirstPlaceUser();
      await this.fecthSecondPlaceUser();
      await this.fecthThirdPlaceUser();
      this.questionBlockPageFirstRead();
      this.favoriteBlockPageFirstRead();
      this.rankingBlockPageFirstRead();
      this.yesOrNoBlockPageFirstRead();
      this.textBlockPageFirstRead();
    },
    async fecthRandomCurrentUserLikesFavoriteBlocks() {
      await axios
        .get("/api/v1/favorite_blocks/random_current_user_likes_blocks")
        .then((res) => (this.randomCurrentUserLikesFavoriteBlocks = res.data));
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
    async fecthFirstPlaceUser() {
      if (this.getLikingBlocksOwingUserIds[0] == undefined) return;

      await axios
        .get(`/api/v1/users/${this.getLikingBlocksOwingUserIds[0].user_id}`)
        .then((res) => (this.firstPlaceUser = res.data));
    },
    async fecthSecondPlaceUser() {
      if (this.getLikingBlocksOwingUserIds[1] == undefined) return;

      await axios
        .get(`/api/v1/users/${this.getLikingBlocksOwingUserIds[1].user_id}`)
        .then((res) => (this.secondPlaceUser = res.data));
    },
    async fecthThirdPlaceUser() {
      if (this.getLikingBlocksOwingUserIds[2] == undefined) return;

      await axios
        .get(`/api/v1/users/${this.getLikingBlocksOwingUserIds[2].user_id}`)
        .then((res) => (this.thirdPlaceUser = res.data));
    },
    favoriteBlockPageChange(pageNumber) {
      this.displayFavoriteBlocks = this.randomCurrentUserLikesFavoriteBlocks.slice(
        this.favoriteBlockPageSize * (pageNumber - 1),
        this.favoriteBlockPageSize * pageNumber
      );
    },
    favoriteBlockPageFirstRead() {
      this.favoriteBlocklength = Math.ceil(
        this.randomCurrentUserLikesFavoriteBlocks.length /
          this.favoriteBlockPageSize
      );
      this.displayFavoriteBlocks = this.randomCurrentUserLikesFavoriteBlocks.slice(
        0,
        this.favoriteBlockPageSize
      );
    },
    questionBlockPageChange(pageNumber) {
      this.displayQuestionBlocks = this.randomCurrentUserLikesQuestionBlocks.slice(
        this.questionBlockPageSize * (pageNumber - 1),
        this.questionBlockPageSize * pageNumber
      );
    },
    questionBlockPageFirstRead() {
      this.questionBlocklength = Math.ceil(
        this.randomCurrentUserLikesQuestionBlocks.length /
          this.questionBlockPageSize
      );
      this.displayQuestionBlocks = this.randomCurrentUserLikesQuestionBlocks.slice(
        0,
        this.questionBlockPageSize
      );
    },
    rankingBlockPageChange(pageNumber) {
      this.displayRankingBlocks = this.randomCurrentUserLikesRankingBlocks.slice(
        this.rankingBlockPageSize * (pageNumber - 1),
        this.rankingBlockPageSize * pageNumber
      );
    },
    rankingBlockPageFirstRead() {
      this.rankingBlocklength = Math.ceil(
        this.randomCurrentUserLikesRankingBlocks.length /
          this.rankingBlockPageSize
      );
      this.displayRankingBlocks = this.randomCurrentUserLikesRankingBlocks.slice(
        0,
        this.rankingBlockPageSize
      );
    },
    yesOrNoBlockPageChange(pageNumber) {
      this.displayYesOrNoBlocks = this.randomCurrentUserLikesYesOrNoBlocks.slice(
        this.yesOrNoBlockPageSize * (pageNumber - 1),
        this.yesOrNoBlockPageSize * pageNumber
      );
    },
    yesOrNoBlockPageFirstRead() {
      this.yesOrNoBlocklength = Math.ceil(
        this.randomCurrentUserLikesYesOrNoBlocks.length /
          this.yesOrNoBlockPageSize
      );
      this.displayYesOrNoBlocks = this.randomCurrentUserLikesYesOrNoBlocks.slice(
        0,
        this.yesOrNoBlockPageSize
      );
    },
    textBlockPageChange(pageNumber) {
      this.displayTextBlocks = this.randomCurrentUserLikesTextBlocks.slice(
        this.textBlockPageSize * (pageNumber - 1),
        this.textBlockPageSize * pageNumber
      );
    },
    textBlockPageFirstRead() {
      this.textBlocklength = Math.ceil(
        this.randomCurrentUserLikesTextBlocks.length / this.textBlockPageSize
      );
      this.displayTextBlocks = this.randomCurrentUserLikesTextBlocks.slice(
        0,
        this.textBlockPageSize
      );
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

.top-three-recommended-users-space {
  background-color: #b39e9e;
  padding: 2rem;
}

.place-text {
  color: #fffffb;
  background: #f29c9f;
  margin: 1.4em 0;
  padding: 0.3em 0 0.3em 0.5em;
  box-shadow: 0 0 0 5px #f29c9f;
  border: 3px dashed #fffffb;
}
</style>
