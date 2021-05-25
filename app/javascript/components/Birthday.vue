<template>
  <v-row class="bg-brown-400" justify="center" align-content="center">
    <v-col cols="12" sm="12">
      <div class="text-6xl top-sub-title mb-10">
        <v-icon x-large color="white">mdi-cake-variant</v-icon>
        今月誕生日の社員さん
        <v-icon x-large color="white">mdi-cake-variant</v-icon>
      </div>
    </v-col>
    <v-col cols="12" sm="10">
      <div
        class="text-6xl text-white border-dashed border-t-8 border-b-8 border-white pb-2 inline-block"
      >
        HAPPY BIRTHDAY!!
      </div>
    </v-col>
    <v-col
      v-for="birthdayUserProfile in birthdayUserProfiles"
      :key="birthdayUserProfile.public_uid"
      cols="3"
      class="border-dotted border-white border-2 m-5"
    >
      <v-card class="mx-auto" max-width="344" outlined color="brown lighten-5">
        <v-card color="brown lighten-2" class="white--text">
          誕生日 {{ birthdayUserProfile.birthday | moment }}
        </v-card>
        <v-img :src="birthdayUserProfile.user.image.url" height="180px" />

        <div class="text-center font-bold text-3xl pt-5 text-brown-600">
          {{ birthdayUserProfile.user.name }} さん
        </div>

        <v-card-actions>
          <v-spacer />
          <v-btn
            color="brown lighten-1"
            class="white--text"
            small
            tile
            @click="moveToUserProfilePage(birthdayUserProfile)"
          >
            社員プロフィールを見る
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
import axios from "axios";
import moment from "moment";

export default {
  filters: {
    moment: function(date) {
      return moment(date).format("MM月DD日");
    },
  },
  data() {
    return {
      birthdayUserProfiles: [],
    };
  },
  mounted() {
    this.firstRead();
  },
  methods: {
    async firstRead() {
      await this.fetchBirthdayUserProfiles();
    },
    async fetchBirthdayUserProfiles() {
      await axios
        .get("/api/v1/profiles/birthday_user_profiles")
        .then((res) => (this.birthdayUserProfiles = res.data));
    },
    moveToUserProfilePage(profile) {
      this.$router.push(`/profiles/${profile.public_uid}`);
    },
  },
};
</script>
