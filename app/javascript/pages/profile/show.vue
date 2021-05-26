<!-- app/javascript/pages/profile/show.vue -->
<template>
  <div>
    <v-container>
      <v-row justify="center" align-content="center">
        <v-btn class="m-5 white--text" color="brown">＜</v-btn>
        <v-btn class="m-5 white--text" color="brown" @click="moveToProfilesPage"
          >プロフィール一覧に戻る</v-btn
        >
        <v-btn class="m-5 white--text" color="brown">＞</v-btn>
      </v-row>
    </v-container>
    <v-container
      class="border-gray-500 rounded-xl border-2 m-20 note"
      v-if="shown"
    >
      <BasicAndAddressBlock :user="user" />

      <FavoriteBlockList :user="user" />

      <QuestionBlockList :user="user" />

      <RankingBlockList :user="user" />

      <YesOrNoBlockList :user="user" />

      <TextBlockList :user="user" />
    </v-container>
  </div>
</template>

<script>
// plugins
import axios from "axios";

// Component ----------
import BasicAndAddressBlock from "../../components/BasicAndAddressBlock";
import MyFavoriteBlock from "../../components/my_favorites_block/MyFavoriteBlock";
import TextBlockList from "../../components/text_block/TextBlockList";
import QuestionBlockList from "../../components/question_block/QuestionBlockList";
import YesOrNoBlockList from "../../components/yes_or_no_block/YesOrNoBlockList";
import RankingBlockList from "../../components//ranking_block/RankingBlockList";
import FavoriteBlockList from "../../components/favorite_block/FavoriteBlockList";

export default {
  components: {
    BasicAndAddressBlock,
    MyFavoriteBlock,
    QuestionBlockList,
    YesOrNoBlockList,
    RankingBlockList,
    TextBlockList,
    FavoriteBlockList,
  },
  props: {
    id: {
      type: String,
      require: true,
      default: "",
    },
  },
  data() {
    return {
      profile: {},
      user: {},
      shown: false,
    };
  },
  mounted() {
    this.firstRead();
  },
  created() {
    document.title = `プロフ閲覧 - プロフちゃん`;
  },
  methods: {
    async firstRead() {
      await this.fetchProfile();
      await this.fetchUser();
      // これをしないと先に値を渡す前に子コンポーネントが読まれてしまう
      this.shown = true;
    },
    async fetchProfile() {
      await axios
        .get(`/api/v1/profiles/${this.id}`)
        .then((res) => (this.profile = res.data));
    },
    async fetchUser() {
      await axios
        .get(`/api/v1/users/${this.profile.user.id}`)
        .then((res) => (this.user = res.data));
    },
    moveToProfilesPage() {
      this.$router.push("/profiles");
    },
  },
  beforeRouteEnter(to, from, next) {
    axios
      .get(`/api/v1/profiles/${to.params.id}`)
      .then((res) => {
        next();
      })
      .catch((err) => {
        next("/profiles");
      });
  },
};
</script>

<style scoped>
.note {
  width: 80%;
  padding: 0 1em;
  background: linear-gradient(rgb(255, 245, 245) 5px, transparent 0.6px) #fffbf2;
  background-size: auto 5em;
  border-top: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
  border-left: 1px solid #ccc;
  border-right: 1px solid #ccc;
  overflow: hidden;
}
</style>
