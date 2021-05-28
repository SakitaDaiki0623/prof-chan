<!-- app/javascript/pages/profile/index.vue -->
<template>
  <div class="bg-backimage bg-cover bg-fixed text-gray-600">
    <v-container class="bg-brown-600 shadow-lg mb-20 mt-20">
      <p class="top-sub-title text-4xl text-center mb-20 pa-5">社員プロフ一覧</p>
      <v-row class="mb-10 pa-10">
        <v-col
          v-for="profile in displayProfiles"
          :key="profile.public_uid"
          cols="12"
          md="6"
          lg="4"
          class="border-white border-2 border-dotted"
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
          @next="moveToTop"
          @previous="moveToTop"
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
    this.firstRead();
    document.title = "プロフ一覧 - プロフちゃん";
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
      this.moveToTop();
      this.displayProfiles = this.profiles.slice(
        this.pageSize * (pageNumber - 1),
        this.pageSize * pageNumber
      );
    },
    moveToTop() {
      const duration = 10; // 移動速度（1秒で終了）
      const interval = 5; // 0.025秒ごとに移動
      const step = -window.scrollY / Math.ceil(duration / interval); // 1回に移動する距離
      const timer = setInterval(() => {
        window.scrollBy(0, step); // スクロール位置を移動

        if (window.scrollY <= 0) {
          clearInterval(timer);
        }
      }, interval);
    },
  },
};
</script>

<style scoped></style>
