<template>
  <div v-if="firstPlaceUserExist" class="bg">
    <v-row justify="center" align-content="center">
      <v-col cols="12" sm="8" align-self="center">
        <div
          class="ext-4xl bordertext-xl text-center bg-brown-50 pa-10 ma-5 rounded-full md:t-brown-500 border-4 border-dashed"
        >
          <v-icon medium> mdi-star-box </v-icon>
          あなたにおすすめの社員さん
          <v-icon medium> mdi-star-box </v-icon>
        </div>
      </v-col>
      <v-col cols="12" sm="4">
        <img src="../images/prof_open_happy.png" class="max-w-xs mx-auto" />
      </v-col>
    </v-row>
    <v-row
      justify="center"
      align-content="center"
      class="pa-10 bg-brown-500 border-brown-900 border-2 border-dotted"
    >
      <v-col cols="12" sm="12" md="6" lg="4" xl="3">
        <ProfCard :user="firstPlaceUser" :is-this-edit-page="false" />
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
        <v-col cols="12" sm="12" align="center">
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
          <v-card class="rounded-2xl pa-5" outlined color="brown lighten-2">
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
      <v-col cols="12" sm="12" md="6" lg="4" xl="3">
        <ProfCard :user="secondPlaceUser" :is-this-edit-page="false" />
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
        <v-col cols="12" sm="12" align="center">
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
          <v-card class="rounded-2xl pa-5" outlined color="brown lighten-2">
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
      <v-col cols="12" sm="12" md="6" lg="4" xl="3">
        <ProfCard :user="thirdPlaceUser" :is-this-edit-page="false" />
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
        <v-col cols="12" sm="12" align="center">
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
          <v-card class="rounded-2xl pa-5" outlined color="brown lighten-2">
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
