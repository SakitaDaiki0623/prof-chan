<template>
  <div class="top">
    <div class="top-three-recommended-users-space">
      <div class="text-center text-5xl text-white">
        あなたがよく共感する社員TOP3
      </div>
      <v-row class="py-5 h-96" justify="center">
        <v-col align-self="center" cols="12" sm="3">
          <v-card class="second-place" outlined contain>
            <v-img
              :src="secondPlaceUser.image.url"
              max-height="150"
              max-width="250"
            ></v-img>
          </v-card>
        </v-col>
        <v-col align-self="start" cols="12" sm="3">
          <v-card class="first-place" outlined contain>
            <v-img
              :src="firstPlaceUser.image.url"
              max-height="150"
              max-width="250"
            ></v-img>
          </v-card>
        </v-col>
        <v-col align-self="end" cols="12" sm="3">
          <v-card class="first-place" outlined contain>
            <v-img
              :src="thirdPlaceUser.image.url"
              max-height="150"
              max-width="250"
            ></v-img>
          </v-card>
        </v-col>
      </v-row>
    </div>
    <div class="top-bg">
      <v-row>
        <v-col cols="12" sm="12">
          <div class="text-center text-5xl">
            - - - - 共感したブロック一覧- - - -
          </div>
        </v-col>
      </v-row>
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
      <div class="top-sub-title my-10">
        ランキングブロック
      </div>
      <v-row>
        <v-col
          v-for="rankingBlock in randomCurrentUserLikesRankingBlocks"
          :key="rankingBlock.id"
          cols="12"
          sm="4"
        >
          <div>作成者: {{ rankingBlock.owing_user.name }}</div>
          <v-card
            class="rounded-2xl p-5 note-box"
            outlined
            color="light-green lighten-5"
          >
            <p class="text-2xl font-bold text-gray-600 px-3 pt-3">
              {{ rankingBlock.title }}
            </p>
            <v-card class="p-2 m-3 rounded-full" outlined color="white">
              <label for="1st place" class="ranking-label">1st</label
              >{{ rankingBlock.first_place }}
            </v-card>
            <v-card class="p-2 m-3 rounded-full" outlined color="white">
              <label for="2nd place" class="ranking-label">2nd</label
              >{{ rankingBlock.second_place }}
            </v-card>
            <v-card class="p-2 m-3 rounded-full" outlined color="white">
              <label for="3rd place" class="ranking-label">3rd</label
              >{{ rankingBlock.third_place }}
            </v-card>
          </v-card>
        </v-col>
      </v-row>

      <div class="top-sub-title my-10">
        Yes or No ブロック
      </div>
      <v-row>
        <v-col
          v-for="yesOrNoBlock in randomCurrentUserLikesYesOrNoBlocks"
          :key="yesOrNoBlock.id"
          cols="12"
          sm="4"
        >
          <div>作成者: {{ yesOrNoBlock.owing_user.name }}</div>

          <v-card
            class="rounded-2xl p-5 note-box"
            outlined
            color="orange lighten-4"
          >
            <p class="text-2xl font-bold text-gray-600 px-3 pt-3">
              {{ yesOrNoBlock.title }}
            </p>
            <template v-for="yes_or_no_item in yesOrNoBlock.yes_or_no_items">
              <div :key="yes_or_no_item.id">
                <v-card class="p-2 m-2" outlined color="white">
                  <v-row align="center">
                    <v-col cols="12" sm="7">
                      {{ yes_or_no_item.content }}
                    </v-col>
                    <v-col v-if="yes_or_no_item.answer" cols="12" sm="5">
                      <span class="rounded-full border-red-500 border-2 p-2"
                        >YES</span
                      >
                      / NO
                    </v-col>
                    <v-col v-else cols="12" sm="5">
                      YES /
                      <span class="rounded-full border-red-500 border-2 p-2"
                        >NO</span
                      >
                    </v-col>
                  </v-row>
                </v-card>
              </div>
            </template>
          </v-card>
        </v-col>
      </v-row>

      <div class="top-sub-title my-10">
        テキストブロック
      </div>
      <transition-group tag="v-row" appear>
        <v-col
          v-for="textBlock in randomCurrentUserLikesTextBlocks"
          :key="textBlock.id"
          cols="12"
          sm="4"
        >
          <div>作成者: {{ textBlock.owing_user.name }}</div>
          <v-card
            class="rounded-2xl p-5 note-box"
            outlined
            color="teal accent-1"
          >
            <p class="text-2xl font-bold text-gray-600 px-3 pt-3">
              {{ textBlock.title }}
            </p>
            <v-card
              class="p-3 rounded-lg"
              outlined
              color="white"
              min-height="200px"
            >
              {{ textBlock.text }}
            </v-card>
          </v-card>
        </v-col>
      </transition-group>
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
      firstPlaceUser: {},
      secondPlaceUser: {},
      thirdPlaceUser: {},
    };
  },
  computed: {
    getLikingBlocksOwingUserIds() {
      // 参考: https://www.suzu6.net/posts/96-js-count-element/
      // 各ブロックでユーザーが共感しているブロックを持つユーザーのidを取得
      // 全ての配列を結合させる
      const allUserIds = this.questionLikedUserIds.concat(
        this.rankingLikedUserIds,
        this.yesOrNoLikedUserIds,
        this.textLikedUserIds
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
    this.firstRead();
  },
  methods: {
    async firstRead() {
      await this.fecthRandomCurrentUserLikesQuestionBlocks();
      await this.fecthRandomCurrentUserLikesRankingBlocks();
      await this.fecthRandomCurrentUserLikesYesOrNoBlocks();
      await this.fecthRandomCurrentUserLikesTextBlocks();
      await this.fecthFirstPlaceUser();
      await this.fecthSecondPlaceUser();
      await this.fecthThirdPlaceUser();
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
      await axios
        .get(`/api/v1/users/${this.getLikingBlocksOwingUserIds[0].user_id}`)
        .then((res) => (this.firstPlaceUser = res.data));
    },
    async fecthSecondPlaceUser() {
      await axios
        .get(`/api/v1/users/${this.getLikingBlocksOwingUserIds[1].user_id}`)
        .then((res) => (this.secondPlaceUser = res.data));
    },
    async fecthThirdPlaceUser() {
      await axios
        .get(`/api/v1/users/${this.getLikingBlocksOwingUserIds[2].user_id}`)
        .then((res) => (this.thirdPlaceUser = res.data));
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
</style>
