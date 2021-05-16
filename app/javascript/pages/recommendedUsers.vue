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
  </div>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";

export default {
  data() {
    return {
      datas: [],
      firstPlaceUser: {},
      secondPlaceUser: {},
      thirdPlaceUser: {},
      recommendedUsers: [],
      ids: [],
    };
  },
  computed: {
    ...mapState("questionBlocks", ["questionBlocks"]),
    ...mapState("rankingBlocks", ["rankingBlocks"]),
    ...mapState("yesOrNoBlocks", ["yesOrNoBlocks"]),
    ...mapState("textBlocks", ["textBlocks"]),
    ...mapState("users", ["currentUser"]),

    currentUserBlocklikesUsres() {
      const users = [];
      this.currentUserQuestionBlocks.forEach((block) =>
        block.users.forEach((user) => users.push(user))
      );
      this.currentUserRankingBlocks.forEach((block) =>
        block.users.forEach((user) => users.push(user))
      );
      this.currentUserYesOrNoBlocks.forEach((block) =>
        block.users.forEach((user) => users.push(user))
      );
      this.currentUserTextBlocks.forEach((block) =>
        block.users.forEach((user) => users.push(user))
      );

      return users;
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
    getLikingBlocksOwingUserIds() {

      const allUserIds = this.currentUserBlocklikesUsres.map((user) => user.id);

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
