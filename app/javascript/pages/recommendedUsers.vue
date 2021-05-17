<template>
  <div class="top">
    <div class="top-three-recommended-users-space">
      <div class="text-center text-5xl text-white">
        あなたによく共感する社員TOP3
      </div>
      <v-row class="py-5 h-96" justify="center">
        <v-col align-self="center" cols="12" sm="3">
          <v-card class="second-place" outlined contain>
            <v-img
              :src="secondPlaceUser.image"
              max-height="150"
              max-width="250"
            ></v-img>
          </v-card>
        </v-col>
        <v-col align-self="start" cols="12" sm="3">
          <v-card class="first-place" outlined contain>
            <v-img
              :src="firstPlaceUser.image"
              max-height="150"
              max-width="250"
            ></v-img>
          </v-card>
        </v-col>
        <v-col align-self="end" cols="12" sm="3">
          <v-card class="first-place" outlined contain>
            <v-img
              :src="thirdPlaceUser.image"
              max-height="150"
              max-width="250"
            ></v-img>
          </v-card>
        </v-col>
      </v-row>
    </div>
    <div class="top-sub-title m-5">1番共感してくれる社員</div>
    <v-row>
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

export default {
  data() {
    return {
      firstPlaceUser: {},
      secondPlaceUser: {},
      thirdPlaceUser: {},
      currentUserProfileBlock: {},
      // firstPlaceUserProfileBlock: {},
      // secondPlaceUserProfileBlock: {},
      // thirdPlaceUserProfileBlock: {},
    };
  },
  computed: {
    ...mapState("questionBlocks", ["questionBlocks"]),
    ...mapState("rankingBlocks", ["rankingBlocks"]),
    ...mapState("yesOrNoBlocks", ["yesOrNoBlocks"]),
    ...mapState("textBlocks", ["textBlocks"]),
    ...mapState("users", ["currentUser"]),

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
        this.currentUserQuestionBlocks,
        this.currentUserRankingBlocks,
        this.currentUserYesOrNoBlocks,
        this.currentUserTextBlocks
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
      await this.fecthFirstPlaceUser();
      await this.fecthSecondPlaceUser();
      await this.fecthThirdPlaceUser();
    },
    async fecthFirstPlaceUser() {
      await axios
        .get(`/api/v1/users/${this.topThreeUserIdAndTotalLikes[0].user_id}`)
        .then((res) => (this.firstPlaceUser = res.data));
    },
    async fecthSecondPlaceUser() {
      await axios
        .get(`/api/v1/users/${this.topThreeUserIdAndTotalLikes[1].user_id}`)
        .then((res) => (this.secondPlaceUser = res.data));
    },
    async fecthThirdPlaceUser() {
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
</style>
