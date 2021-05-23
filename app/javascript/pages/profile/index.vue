<!-- app/javascript/pages/profile/index.vue -->
<template>
  <div class="bg-backimage bg-cover bg-fixed text-gray-600">
    <v-container class="note shadow-lg mb-20 mt-20">
      <p class="top-sub-title text-4xl text-center mb-20 p-5">
        社員プロフ一覧
      </p>
      <v-row class="mb-10">
        <v-col
          v-for="profile in displayProfiles"
          :key="profile.public_uid"
          cols="12"
          sm="4"
        >
          <IndexProfCard :profile="profile" />
        </v-col>
      </v-row>
      <div class="text-center">
        <v-pagination
          v-model="page"
          :length="length"
          circle
          @input="pageChange"
          color="brown lighten-1"
        ></v-pagination>
      </div>
    </v-container>
  </div>
</template>

<script>
import axios from "axios";
import { mapState, mapActions } from "vuex";

// Component ----------
import IndexProfCard from "../../components/IndexProfCard";

export default {
  components: {
    IndexProfCard,
  },
  data() {
    return {
      displayProfiles: [],
      profiles: [],
      pageSize: 9,
      page: 1,
      length: 0,
    };
  },
  mounted() {
    document.title = "プロフ一覧 - プロフちゃん";
  },
  created() {
    this.firstRead();
  },
  methods: {
    async firstRead() {
      await this.fetchProfiles();
      this.length = Math.ceil(this.profiles.length / this.pageSize);
      this.displayProfiles = this.profiles.slice(0, this.pageSize);
    },
    async fetchProfiles() {
      await axios
        .get("/api/v1/profiles")
        .then((response) => (this.profiles = response.data));
    },
    pageChange(pageNumber) {
      this.displayProfiles = this.profiles.slice(
        this.pageSize * (pageNumber - 1),
        this.pageSize * pageNumber
      );
    },
  },
};
</script>

<style scoped></style>
