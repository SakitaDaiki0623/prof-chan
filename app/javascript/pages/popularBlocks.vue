<template>
  <div class="top">
    <div class="top-bg">
      <div>
        <v-row>
          <v-col cols="12" sm="12">
            <div class="text-center text-5xl">
              - - - - 社内人気のあるブロック- - - -
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

      <!-- TODO: 後ほどコンポーネント化 -->
      <v-row>
        <v-col
          v-for="questionBlock in questionPopularBlocksTopThree"
          :key="questionBlock.id"
          cols="12"
          sm="4"
        >
          <div>作成者: {{ questionBlock.owing_user.name }}</div>
          <QuestionBlockCard :question-block="questionBlock" />
        </v-col>
      </v-row>
    </div>
    <!-- /クエスチョンブロック -->

    <!-- ランキングブロック -->
    <div class="py-10 px-20" v-show="visible" :class="{ fadeIn: visible }">
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
          <div>作成者: {{ rankingBlock.owing_user.name }}</div>
          <RankingBlockCard :ranking-block="rankingBlock" />
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
                <v-img :src="user.image.url"></v-img>
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
          <div>作成者: {{ yesOrNoBlock.owing_user.name }}</div>
          <YesOrNoBlockCard :yes-or-no-block="yesOrNoBlock" />
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
                <v-img :src="user.image.url"></v-img>
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
          <div>作成者: {{ textBlock.owing_user.name }}</div>
          <TextBlockCard :text-block="textBlock" />
        </v-col>
      </transition-group>
    </div>
    <!-- /テキストブロック -->
  </div>
</template>

<script>
import axios from "axios";
import TextBlockCard from "../components/text_block/TextBlockCard";
import QuestionBlockCard from "../components/question_block/QuestionBlockCard";
import YesOrNoBlockCard from "../components/yes_or_no_block/YesOrNoBlockCard";
import RankingBlockCard from "../components/ranking_block/RankingBlockCard";

export default {
  components: {
    TextBlockCard,
    QuestionBlockCard,
    YesOrNoBlockCard,
    RankingBlockCard,
  },
  data() {
    return {
      recentlyJoinedUserProfiles: [],
      questionPopularBlocks: [],
      rankingPopularBlocks: [],
      yesOrNoPopularBlocks: [],
      textPopularBlocks: [],
      visible: false,
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

.fadeIn {
  animation: fadeIn 2s;
}
@keyframes fadeIn {
  0% {
    opacity: 0;
    transform: translateY(100px);
  }
  100% {
    opacity: 1;
    transform: translateY(0px);
  }
}
</style>
