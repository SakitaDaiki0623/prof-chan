<template>
  <v-hover v-slot="{ hover }">
    <div
      :id="'profile-index-card-' + profile.public_uid"
      :class="{ 'on-hover': hover }"
      class="prof-card"
      @click="openProfileShowPage(profile)"
    >
      <v-card
        color="brown lighten-2"
        outlined
      >
        <div>
          <v-row
            justify="center"
            align-content="center"
          >
            <v-img
              class="ring-4 rounded-full ring-gray-600 text-center sample_box2_3"
              :src="profile.user.image.url"
              max-height="250px"
              max-width="250px"
            />
          </v-row>
        </div>
      </v-card>
      <v-card
        color="brown lighten-5 text-center"
        outlined
      >
        <div
          class="pa-3 text-4xl font-bold border-dotted border-b-2 border-gray-400"
        >
          <span class="name-text">{{ profile.user.name }}</span>さん
        </div>
      </v-card>
    </div>
  </v-hover>
</template>

<script>
import moment from "moment";

export default {
  filters: {
    moment: function (date) {
      return moment(date).format("YYYY/MM/DD");
    },
  },
  props: {
    profile: {
      type: Object,
      required: true,
    },
  },
  computed: {
    translateGender() {
      return this.profile.gender == "male" ? "男性" : "女性";
    },
  },
  methods: {
    openProfileShowPage(profile) {
      this.$router.push(`/profiles/${profile.public_uid}`).catch((err) => {});
    },
  },
};
</script>

<style scoped>
.sample_box2_3 {
  padding: 1.2em;
  margin: 2em 0;
  background-color: #ffc6c6;
  box-shadow: 0 0 0 8px #ffc6c6;
  border: 2px dashed #ffffff;
  color: #000000;
}

div {
  transition: transform 0.3s ease-in-out;
}

div:not(.on-hover) {
  transform: scale(0.95);
}

.prof-card {
  cursor: pointer;
}
</style>
