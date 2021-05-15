<template>
  <div class="top text-center">
    <div class="top-bg">
      <div>
        <v-row>
          <v-col cols="12" sm="12">
            <div class=" text-5xl">
              - - - - 人気のプロフブロック- - - -
            </div>
          </v-col>
        </v-row>
      </div>
    </div>

    <div class="py-10 px-20">
      <!-- クエスチョンブロック -->
      <div class="top-sub-title my-10">
        クエスチョンブロック
      </div>
      <v-row>
        <v-col
          v-for="questionBlock in questionPopularBlocksTopThree"
          :key="questionBlock.id"
          cols="12"
          sm="4"
        >
          <div>作成者: {{ questionBlock.user.name }}</div>
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
      <div>
        <v-row>
          <v-col
            v-for="questionBlock in questionPopularBlocksTopThree"
            :key="questionBlock.id"
            cols="12"
            sm="4"
          >
            <v-card outlined color="brown lighten-3" height="100" class="p-2">
              <v-col
                v-for="user in questionBlock.users"
                :key="user.id"
                cols="10"
                sm="2"
                class="inline-block"
              >
                <v-img :src="user.image"></v-img>
              </v-col>
            </v-card>
          </v-col>
        </v-row>
      </div>
    </div>
    <!-- /クエスチョンブロック -->

    <!-- ランキングブロック -->
    <div class="py-10 px-20">
      <div class="top-sub-title my-10">
        ランキングブロック
      </div>
      <v-row>
        <v-col
          v-for="rankingBlock in rankingPopularBlocksTopThree"
          :key="rankingBlock.id"
          cols="12"
          sm="4"
        >
          <div>作成者: {{ rankingBlock.user.name }}</div>
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
      <div>
        <v-row>
          <v-col
            v-for="rankingBlock in rankingPopularBlocksTopThree"
            :key="rankingBlock.id"
            cols="12"
            sm="4"
          >
            <v-card outlined color="brown lighten-3" height="100" class="p-2">
              <v-col
                v-for="user in rankingBlock.users"
                :key="user.id"
                cols="10"
                sm="2"
                class="inline-block"
              >
                <v-img :src="user.image"></v-img>
              </v-col>
            </v-card>
          </v-col>
        </v-row>
      </div>
    </div>
    <!-- /ランキングブロック -->

    <!-- Yes or No ブロック -->
    <div class="py-10 px-20">
      <div class="top-sub-title my-10">
        Yes or No ブロック
      </div>
      <v-row>
        <v-col
          v-for="yesOrNoBlock in yesOrNoPopularBlocksTopThree"
          :key="yesOrNoBlock.id"
          cols="12"
          sm="4"
        >
          <div>作成者: {{ yesOrNoBlock.user.name }}</div>

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
      <div>
        <v-row>
          <v-col
            v-for="yesOrNoBlock in yesOrNoPopularBlocksTopThree"
            :key="yesOrNoBlock.id"
            cols="12"
            sm="4"
          >
            <v-card outlined color="brown lighten-3" height="100" class="p-2">
              <v-col
                v-for="user in yesOrNoBlock.users"
                :key="user.id"
                cols="10"
                sm="2"
                class="inline-block"
              >
                <v-img :src="user.image"></v-img>
              </v-col>
            </v-card>
          </v-col>
        </v-row>
      </div>
    </div>
    <!-- /Yes or No ブロック -->

    <!-- テキストブロック -->
    <div class="py-10 px-20">
      <div class="top-sub-title my-10">
        テキストブロック
      </div>
      <transition-group tag="v-row" appear>
        <v-col
          v-for="textBlock in textPopularBlocksTopThree"
          :key="textBlock.id"
          cols="12"
          sm="4"
        >
          <div>作成者: {{ textBlock.user.name }}</div>
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
      <div>
        <v-row>
          <v-col
            v-for="textBlock in textPopularBlocksTopThree"
            :key="textBlock.id"
            cols="12"
            sm="4"
          >
            <v-card outlined color="brown lighten-3" height="100" class="p-2">
              <v-col
                v-for="user in textBlock.users"
                :key="user.id"
                cols="10"
                sm="2"
                class="inline-block"
              >
                <v-img :src="user.image"></v-img>
              </v-col>
            </v-card>
          </v-col>
        </v-row>
      </div>
    </div>
    <!-- /テキストブロック -->
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      recentlyJoinedUserProfiles: [],
      questionPopularBlocks: [],
      rankingPopularBlocks: [],
      yesOrNoPopularBlocks: [],
      textPopularBlocks: [],
    };
  },
  computed: {
    overallTopThreeBlocks() {},
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
    this.firstRead();
  },
  methods: {
    async firstRead() {
      await this.fetchRecentlyJoinedUserProfiles();
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
