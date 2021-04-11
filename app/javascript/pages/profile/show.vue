<!-- app/javascript/pages/profile/show.vue -->
<template>
  <div
    class="bg-backimage-02 bg-cover bg-fixed text-gray-600 font-prof-default"
  >
    <v-container>
      <p class="text-5xl font-bold note mb-10">
        {{ profile.user.name }} さんのプロフィール
      </p>
      <v-row class="mb-10">
        <v-col
          cols="12"
          sm="6"
        >
          <BasicProfCard :profile="profile" />
        </v-col>
      </v-row>
    </v-container>
    <v-row justify="space-around">
      <v-card-actions>
        <v-btn
          x-large
          color="light-green accent-2"
          class="font-prof-default black--text"
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
    return {
      profile: {
        height: "",
        gender: "",
        blood_type: "",
        prefecture_id: "",
        birthday: "",
        day_of_joinning: "",
        user: {
          name: "",
          image: "",
        },
      },
    };
  },
  created() {
    // [TODO: Refactor] vuexから値を取得できるように変更
    this.$axios
      .get(`/profiles/${this.id}`)
      .then((response) => (this.profile = response.data))
      .catch((err) => console.log(err.status));
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

<style scoped>
.note {
  width: 80%;
  padding: 0 1em;
  background: linear-gradient(#ccc 0.1px, transparent 0.6px) #fffbf2;
  background-size: auto 2.5em;
  line-height: 2.5em;
  border-bottom: 1px solid #ccc;
  border-left: 1px solid #ccc;
  border-right: 1px solid #ccc;
  overflow: hidden;
}
</style>
