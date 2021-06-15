<template>
  <v-row
    class="bg-brown-400 pa-3"
    justify="center"
    align-content="center"
  >
    <v-col
      cols="12"
      sm="12"
    >
      <div class="text-xl top-sub-title mb-5 lg:text-4xl lg:mb-10">
        <v-icon
          large
          color="white"
        >
          mdi-account-group-outline
        </v-icon>
        最近入社した社員さん
        <v-icon
          large
          color="white"
        >
          mdi-account-group-outline
        </v-icon>
      </div>
    </v-col>
    <v-col
      cols="12"
      sm="10"
    >
      <div
        class="text-2xl lg:text-4xl text-white border-dashed border-t-8 border-b-8 border-white pb-2 inline-block"
      >
        WELCOME!!
      </div>
    </v-col>
    <v-col
      v-for="recentlyJoinedUserProfile in recentlyJoinedUserProfiles"
      :key="recentlyJoinedUserProfile.public_uid"
      cols="12"
      sm="12"
      md="3"
      class="border-dotted border-white border-2 ma-5"
    >
      <v-hover v-slot="{ hover }">
        <v-card
          class="mx-auto"
          :class="{ 'on-hover': hover }"
          max-width="344"
          outlined
          color="brown lighten-5"
          @click="moveToUserProfilePage(recentlyJoinedUserProfile)"
        >
          <v-img
            :src="recentlyJoinedUserProfile.user.image.url"
            height="180px"
          />

          <div class="text-center font-bold text-4xl pt-5 text-brown-600">
            {{ recentlyJoinedUserProfile.user.name }} さん
          </div>
          <v-card
            color="brown lighten-2"
            class="white--text"
          >
            {{ recentlyJoinedUserProfile.day_of_joinning | moment }} 入社
          </v-card>
        </v-card>
      </v-hover>
    </v-col>
  </v-row>
</template>

<script>
import axios from "axios";
import moment from "moment";

export default {
  filters: {
    moment: function (date) {
      return moment(date).format("YYYY年MM月DD日");
    },
  },
  data() {
    return {
      recentlyJoinedUserProfiles: [],
    };
  },
  mounted() {
    this.firstRead();
  },
  methods: {
    async firstRead() {
      await this.fetchRecentlyJoinedUserProfiles();
    },
    async fetchRecentlyJoinedUserProfiles() {
      await axios
        .get("/api/v1/profiles/recently_joined_user_profiles")
        .then((res) => (this.recentlyJoinedUserProfiles = res.data));
    },
    moveToUserProfilePage(profile) {
      this.$router.push(`/profiles/${profile.public_uid}`).catch((err) => {});
    },
  },
};
</script>

<style scoped>
.v-card {
  transition: transform 0.3s ease-in-out;
}

.v-card:not(.on-hover) {
  transform: scale(0.95);
}
</style>
