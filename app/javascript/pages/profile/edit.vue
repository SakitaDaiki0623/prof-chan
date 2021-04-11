<!-- app/javascript/pages/profile/show.vue -->
<template>
  <div
    class="bg-backimage-02 bg-cover bg-fixed text-gray-600 font-prof-default"
  >
    <v-container>
      <p class="text-5xl font-bold note mb-10">
        {{ profile.user.name }} さんのプロフィール編集
      </p>
      <v-row class="mb-10">
        <v-col cols="12" sm="6">
          <BasicProfCard :profile="profile" />
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
// plugins
import axios from "axios";
import { mapState } from "vuex";

// Component ----------
import BasicProfCard from "../../components/BasicProfCard";

export default {
  components: {
    BasicProfCard,
  },
  props: {
    id: String,
  },
  data() {
    return {};
  },
  computed: {
    ...mapState("profiles", ["profiles"]),
    profile() {
      return this.profiles.find((profile) => profile.id == this.id) || {};
    },
  },
  mounted() {
    // [TODO: Refactor] ページごとにタイトルを変更(下記メソッドで実装)
    // document.title = `${ this.profile.user.name } - プロフちゃん`;
    document.title = `プロフィール詳細 - プロフちゃん`;
  },
  methods: {
    moveToProfilesPage() {
      this.$router.push("/profiles");
    },
  },
};
</script>

<style scoped></style>
