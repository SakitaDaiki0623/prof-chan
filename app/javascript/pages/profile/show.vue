<!-- app/javascript/pages/profile/show.vue -->
<template>
  <div
    class="bg-backimage-02 bg-cover bg-fixed text-gray-600"
  >
    <v-container>
      <p class="text-5xl font-bold note mb-10">
        {{ profile.user.name }} さんのプロフィール
      </p>
      <v-row
        class="mb-10"
        justify="center"
      >
        <v-col
          cols="12"
          sm="6"
        >
          <BasicProfCard
            :profile="profile"
            :current-user="currentUser"
          />
          <v-btn
            v-show="isCurrentUser"
            id="edit-basic-profile-btn"
          >
            編集する
          </v-btn>
        </v-col>
      </v-row>
    </v-container>
    <v-row justify="space-around">
      <v-card-actions>
        <v-btn
          x-large
          color="light-green accent-2"
          class="black--text"
          @click="moveToProfilesPage"
        >
          <v-icon left>
            mdi-account-circle
          </v-icon>
          プロフィール閲覧
        </v-btn>
      </v-card-actions>
    </v-row>
  </div>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions } from "vuex";

// Component ----------
import BasicProfCard from "../../components/BasicProfCard";

export default {
  components: {
    BasicProfCard,
  },
  props: {
    id: {
      type: String,
      require: true,
      default: "",
    },
  },
  data() {
    return {};
  },
  computed: {
    ...mapState("profiles", ["profiles"]),
    ...mapState("users", ["currentUser"]),
    ...mapState("textBlocks", ["textBlocks"]),

    profile() {
      return this.profiles.find((profile) => profile.id == this.id) || {};
    },
    isCurrentUser() {
      return this.profile.user.id === this.currentUser.id;
    },
  },
  mounted() {
    this.fetchProfiles();
    this.fetchTextBlocks();
    this.fetchCurrentUser();
    document.title = `プロフィール詳細 - プロフちゃん`;
  },
  methods: {
    ...mapActions("profiles", ["patchProfile", "fetchProfiles"]),
    ...mapActions("textBlocks", ["fetchTextBlocks"]),
    ...mapActions("users", ["fetchCurrentUser"]),

    moveToProfilesPage() {
      this.$router.push("/profiles");
    },
  },
};
</script>

<style scoped>

</style>
