<template>
  <div class="top">
    <!-- 共通画面 -->
    <TopImage v-if="isProviderSlack" />
    <TopImageForEmail v-else />
    <div class="p-20 text-center">
      <RecentlyJoined class="mb-10" />
      <Birthday />
    </div>

    <!-- ユーザごとに変動 -->
    <div>
      <RecommendedUsers class="mb-10" />
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { mapState, mapActions } from "vuex";

import TopImage from "../components/static/TopImage";
import TopImageForEmail from "../components/static/TopImageForEmail";
import RecentlyJoined from "../components/RecentlyJoined";
import Birthday from "../components/Birthday";
import RecommendedUsers from "./recommendedUsers";

export default {
  components: {
    TopImage,
    TopImageForEmail,
    RecentlyJoined,
    Birthday,
    RecommendedUsers,
  },
  data() {
    return {};
  },
  computed: {
    ...mapState("users", ["currentUser"]),
    isProviderSlack() {
      return this.currentUser.provider == "slack" ? true : false;
    },
  },

  mounted() {
    this.firstRead();
  },
  created() {
    document.title = `プロフちゃん`;
  },
  methods: {
    ...mapActions({
      fetchCurrentUser: "users/fetchCurrentUser",
      fetchYesOrNoBlocks: "yesOrNoBlocks/fetchYesOrNoBlocks",
      fetchYesOrNoItems: "yesOrNoBlocks/fetchYesOrNoItems",
      fetchQuestionBlocks: "questionBlocks/fetchQuestionBlocks",
      fetchQuestionItems: "questionBlocks/fetchQuestionItems",
    }),
    async firstRead() {
      await this.fetchCurrentUser();
      // await this.fetchYesOrNoBlocks();
      // await this.fetchYesOrNoItems();
      // await this.fetchQuestionBlocks();
      // await this.fetchQuestionItems();
    },
  },
};
</script>

<style scoped>
.top {
  color: rgb(77, 77, 77);
}
</style>
