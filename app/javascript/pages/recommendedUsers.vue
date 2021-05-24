<template>
  <div class="top" v-if="firstPlaceUserExist">
    <v-row justify="center" align-content="center">
      <v-col cols="12" sm="5" align="right">
        <img src="../images/prof_normal.png" class="image" />
      </v-col>
      <v-col cols="12" sm="5" align="left">
        <div class="text-center text-4xl balloon4">
          あなたにおすすめの社員さん
        </div>
      </v-col>
      <v-col
        v-for="block in firstPlaceUserLikesBlocks"
        :key="block.id"
        cols="12"
        sm="4"
      >
        <div class="border-2 border-gray-500"></div>
        <v-card class="rounded-2xl p-5 note-box" outlined color="red lighten-4">
          <p class="text-2xl font-bold text-gray-600 px-3 py-3">
            {{ block.title }}
          </p>
        </v-card>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";
import NotAnyBookmarkBlock from "../components/NotAnyBookmarkBlock";
import PlaceDoesNotExistCard from "../components/static/PlaceDoesNotExistCard";
import ProfCard from "../components/ProfCard";

export default {
  components: {
    NotAnyBookmarkBlock,
    PlaceDoesNotExistCard,
    ProfCard,
  },
  data() {
    return {
      firstPlaceUser: {},
      secondPlaceUser: {},
      thirdPlaceUser: {},
      currentUserProfileBlock: {},
      favoriteBlocks: [],
      questionBlocks: [],
      rankingBlocks: [],
      yesOrNoBlocks: [],
      textBlocks: [],
    };
  },
  computed: {
    ...mapState("users", ["currentUser"]),

    firstPlaceUserExist() {
      return !!Object.keys(this.firstPlaceUser).length;
    },
    secondPlaceUserExist() {
      return !!Object.keys(this.secondPlaceUser).length;
    },
    thirdPlaceUserExist() {
      return !!Object.keys(this.thirdPlaceUser).length;
    },

    topThreeUserIdAndTotalLikes() {
      const allUserIds = this.currentUserBlocklikesUsres.map((user) => user.id);

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

      const target = arr.splice(0, 3);
      return target; // ex.0: {user_id: "2", value: 12}, 1: {user_id: "3", value: 6}, 2: {user_id: "1", value: 3}
    },

    //Other User Likes Blocks of Current Users
    firstPlaceUserLikesBlocks() {
      const blocks = [];
      this.allCurrentUserBlocks.forEach((block) =>
        block.users.forEach((user) => {
          if (user.id == this.firstPlaceUser.id) {
            blocks.push(block);
          }
        })
      );
      return blocks;
    },
    secondPlaceUserLikesBlocks() {
      const blocks = [];
      this.allCurrentUserBlocks.forEach((block) =>
        block.users.forEach((user) => {
          if (user.id == this.secondPlaceUser.id) {
            blocks.push(block);
          }
        })
      );
      return blocks;
    },
    thirdPlaceUserLikesBlocks() {
      const blocks = [];
      this.allCurrentUserBlocks.forEach((block) =>
        block.users.forEach((user) => {
          if (user.id == this.thirdPlaceUser.id) {
            blocks.push(block);
          }
        })
      );
      return blocks;
    },

    currentUserBlocklikesUsres() {
      const users = [];
      this.allCurrentUserBlocks.forEach((block) =>
        block.users.forEach((user) => users.push(user))
      );
      return users;
    },
    allCurrentUserBlocks() {
      return [].concat(
        this.currentUserFavoriteBlocks,
        this.currentUserQuestionBlocks,
        this.currentUserRankingBlocks,
        this.currentUserYesOrNoBlocks,
        this.currentUserTextBlocks
      );
    },
    currentUserFavoriteBlocks() {
      return (
        this.favoriteBlocks.filter(
          (favoriteBlock) =>
            favoriteBlock.profile_block.id == this.currentUser.profile_block.id
        ) || {}
      );
    },
    currentUserQuestionBlocks() {
      return (
        this.questionBlocks.filter(
          (questionBlock) =>
            questionBlock.profile_block.id == this.currentUser.profile_block.id
        ) || {}
      );
    },
    currentUserRankingBlocks() {
      return (
        this.rankingBlocks.filter(
          (rankingBlock) =>
            rankingBlock.profile_block.id == this.currentUser.profile_block.id
        ) || {}
      );
    },
    currentUserYesOrNoBlocks() {
      return (
        this.yesOrNoBlocks.filter(
          (yesOrNoBlock) =>
            yesOrNoBlock.profile_block.id == this.currentUser.profile_block.id
        ) || {}
      );
    },
    currentUserTextBlocks() {
      return (
        this.textBlocks.filter(
          (textBlock) =>
            textBlock.profile_block.id == this.currentUser.profile_block.id
        ) || {}
      );
    },
  },
  mounted() {
    this.firstRead();
  },

  methods: {
    async firstRead() {
      await this.fetchFavoriteBlocks();
      await this.fetchQuestionBlocks();
      await this.fetchRankingBlocks();
      await this.fetchYesOrNoBlocks();
      await this.fetchTextBlocks();
      await this.fecthFirstPlaceUser();
      await this.fecthSecondPlaceUser();
      await this.fecthThirdPlaceUser();
    },
    async fetchFavoriteBlocks() {
      await axios
        .get("/api/v1/favorite_blocks")
        .then((res) => (this.favoriteBlocks = res.data));
    },
    async fetchQuestionBlocks() {
      await axios
        .get("/api/v1/question_blocks")
        .then((res) => (this.questionBlocks = res.data));
    },
    async fetchRankingBlocks() {
      await axios
        .get("/api/v1/ranking_blocks")
        .then((res) => (this.rankingBlocks = res.data));
    },
    async fetchYesOrNoBlocks() {
      await axios
        .get("/api/v1/yes_or_no_blocks")
        .then((res) => (this.yesOrNoBlocks = res.data));
    },
    async fetchTextBlocks() {
      await axios
        .get("/api/v1/text_blocks")
        .then((res) => (this.textBlocks = res.data));
    },
    async fecthFirstPlaceUser() {
      if (this.topThreeUserIdAndTotalLikes[0] == undefined) return;

      await axios
        .get(`/api/v1/users/${this.topThreeUserIdAndTotalLikes[0].user_id}`)
        .then((res) => (this.firstPlaceUser = res.data));
    },
    async fecthSecondPlaceUser() {
      if (this.topThreeUserIdAndTotalLikes[1] == undefined) return;

      await axios
        .get(`/api/v1/users/${this.topThreeUserIdAndTotalLikes[1].user_id}`)
        .then((res) => (this.secondPlaceUser = res.data));
    },
    async fecthThirdPlaceUser() {
      if (this.topThreeUserIdAndTotalLikes[2] == undefined) return;

      await axios
        .get(`/api/v1/users/${this.topThreeUserIdAndTotalLikes[2].user_id}`)
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

.image {
  max-width: 20rem;
}

.balloon4 {
  position: relative;
  margin: 2em 4em 2em 40px;
  padding: 5px;
  background: #fff0c6;
  border-radius: 30px;
}

.balloon4:before {
  content: "";
  position: absolute;
  left: -38px;
  width: 13px;
  height: 12px;
  bottom: 0;
  background: #fff0c6;
  border-radius: 50%;
}

.balloon4:after {
  content: "";
  position: absolute;
  left: -24px;
  width: 20px;
  height: 18px;
  bottom: 3px;
  background: #fff0c6;
  border-radius: 50%;
}
</style>
