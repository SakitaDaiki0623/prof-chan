<template>
  <div
    v-if="firstPlaceUserExist"
    class="bg"
  >
    <v-row
      justify="center"
      align-content="center"
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
          あなたにおすすめの社員さん
          <v-icon medium>
            mdi-star-box
          </v-icon>
        </div>
      </v-col>
      <v-col
        cols="12"
        sm="4"
      >
        <img
          src="../images/prof_open_happy.png"
          class="max-w-xs mx-auto"
        >
      </v-col>
    </v-row>
    <v-row
      justify="center"
      align-content="center"
      class="pa-10 bg-brown-500 border-brown-900 border-2 border-dotted"
    >
      <v-col
        cols="12"
        sm="12"
        md="6"
        lg="4"
        xl="3"
      >
        <ProfCard
          :user="firstPlaceUser"
          :is-this-edit-page="false"
        />
        <v-btn
          color="brown lighten-1"
          class="white--text"
          small
          tile
          @click="moveToUserProfilePage(firstPlaceUser.profile)"
        >
          社員ブロフィールを見る
        </v-btn>
      </v-col>
      <v-row class="pa-10">
        <v-col
          cols="12"
          sm="12"
          align="center"
        >
          <div
            class="border-white border-dashed border-2 text-center text-white text-lg inline-block pa-5 md:text-2xl"
          >
            あなたと盛り上がりそうな話題
          </div>
        </v-col>
        <v-col
          v-for="block in firstPlaceUserLikesBlocks.splice(0, 3)"
          :key="block.id"
          cols="12"
          sm="12"
          md="4"
          align="center"
        >
          <v-card
            class="rounded-2xl pa-5"
            outlined
            color="brown lighten-2"
          >
            <p class="text-center text-2xl font-bold text-white">
              {{ block.title }}
            </p>
          </v-card>
        </v-col>
      </v-row>
    </v-row>
    <v-row
      v-if="secondPlaceUserExist"
      justify="center"
      align-content="center"
      class="pa-10 bg-brown-500 border-brown-900 border-2 border-dotted"
    >
      <v-col
        cols="12"
        sm="12"
        md="6"
        lg="4"
        xl="3"
      >
        <ProfCard
          :user="secondPlaceUser"
          :is-this-edit-page="false"
        />
        <v-btn
          color="brown lighten-1"
          class="white--text"
          small
          tile
          @click="moveToUserProfilePage(secondPlaceUser.profile)"
        >
          社員ブロフィールを見る
        </v-btn>
      </v-col>
      <v-row class="pa-10">
        <v-col
          cols="12"
          sm="12"
          align="center"
        >
          <div
            class="border-white border-dashed border-2 text-center text-white text-lg inline-block pa-5 md:text-2xl"
          >
            あなたと盛り上がりそうな話題
          </div>
        </v-col>
        <v-col
          v-for="block in secondPlaceUserLikesBlocks.splice(0, 3)"
          :key="block.id"
          cols="12"
          sm="12"
          md="4"
          align="center"
        >
          <v-card
            class="rounded-2xl pa-5"
            outlined
            color="brown lighten-2"
          >
            <p class="text-center text-2xl font-bold text-white">
              {{ block.title }}
            </p>
          </v-card>
        </v-col>
      </v-row>
    </v-row>
    <v-row
      v-if="thirdPlaceUserExist"
      justify="center"
      align-content="center"
      class="pa-10 bg-brown-500 border-brown-900 border-2 border-dotted"
    >
      <v-col
        cols="12"
        sm="12"
        md="6"
        lg="4"
        xl="3"
      >
        <ProfCard
          :user="thirdPlaceUser"
          :is-this-edit-page="false"
        />
        <v-btn
          color="brown lighten-1"
          class="white--text"
          small
          tile
          @click="moveToUserProfilePage(thirdPlaceUser.profile)"
        >
          社員ブロフィールを見る
        </v-btn>
      </v-col>
      <v-row class="pa-10">
        <v-col
          cols="12"
          sm="12"
          align="center"
        >
          <div
            class="border-white border-dashed border-2 text-center text-white text-lg inline-block pa-5 md:text-2xl"
          >
            あなたと盛り上がりそうな話題
          </div>
        </v-col>
        <v-col
          v-for="block in thirdPlaceUserLikesBlocks.splice(0, 3)"
          :key="block.id"
          cols="12"
          sm="12"
          md="4"
          align="center"
        >
          <v-card
            class="rounded-2xl pa-5"
            outlined
            color="brown lighten-2"
          >
            <p class="text-center text-2xl font-bold text-white">
              {{ block.title }}
            </p>
          </v-card>
        </v-col>
      </v-row>
    </v-row>
  </div>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";
import ProfCard from "../components/ProfCard";

export default {
  components: {
    ProfCard,
  },
  data() {
    return {
      firstPlaceUser: {},
      secondPlaceUser: {},
      thirdPlaceUser: {},
      currentUserFavoriteBlocks: [],
      currentUserQuestionBlocks: [],
      currentUserRankingBlocks: [],
      currentUserYesOrNoBlocks: [],
      currentUserTextBlocks: [],
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
      const currentUserBlocklikesUsresExeptCurrentUser = this.currentUserBlocklikesUsres.filter(
        (user) => {
          user.id !== this.currentUser.id;
        }
      );
      const allUserIds = currentUserBlocklikesUsresExeptCurrentUser.map(
        (user) => user.id
      );

      const dict = {};

      for (let key of allUserIds) {
        dict[key] = allUserIds.filter(function (x) {
          return x == key;
        }).length;
      }

      let arr = Object.keys(dict).map((e) => ({ user_id: e, value: dict[e] }));

      arr.sort(function (a, b) {
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
  },
  mounted() {
    this.firstRead();
  },

  methods: {
    async firstRead() {
      await this.fetchFavoriteBlocksCurrentUserHaving();
      await this.fetchQuestionBlocksCurrentUserHaving();
      await this.fetchRankingBlocksCurrentUserHaving();
      await this.fetchYesOrNoBlocksCurrentUserHaving();
      await this.fetchTextBlocksCurrentUserHaving();
      await this.fecthFirstPlaceUser();
      await this.fecthSecondPlaceUser();
      await this.fecthThirdPlaceUser();
    },
    async fetchFavoriteBlocksCurrentUserHaving() {
      await axios
        .get("/api/v1/favorite_blocks/current_user_having")
        .then((res) => (this.currentUserFavoriteBlocks = res.data));
    },
    async fetchQuestionBlocksCurrentUserHaving() {
      await axios
        .get("/api/v1/question_blocks/current_user_having")
        .then((res) => (this.currentUserQuestionBlocks = res.data));
    },
    async fetchRankingBlocksCurrentUserHaving() {
      await axios
        .get("/api/v1/ranking_blocks/current_user_having")
        .then((res) => (this.currentUserRankingBlocks = res.data));
    },
    async fetchYesOrNoBlocksCurrentUserHaving() {
      await axios
        .get("/api/v1/yes_or_no_blocks/current_user_having")
        .then((res) => (this.currentUserYesOrNoBlocks = res.data));
    },
    async fetchTextBlocksCurrentUserHaving() {
      await axios
        .get("/api/v1/text_blocks/current_user_having")
        .then((res) => (this.currentUserTextBlocks = res.data));
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
