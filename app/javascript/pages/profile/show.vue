<!-- app/javascript/pages/profile/show.vue -->
<template>
  <div>
    <Loading v-if="loading" />
    <div v-else>
      <v-container>
        <v-row
          justify="center"
          align-content="center"
        >
          <v-btn
            class="ma-5 white--text"
            color="brown"
            @click="moveToNextProfilePage(previousProfile)"
          >
            ＜
          </v-btn>
          <v-btn
            class="ma-5 white--text"
            color="brown"
            @click="moveToProfilesPage"
          >
            プロフ一覧に戻る
          </v-btn>
          <v-btn
            class="ma-5 white--text"
            color="brown"
            @click="moveToNextProfilePage(nextProfile)"
          >
            ＞
          </v-btn>
        </v-row>
      </v-container>
      <v-container
        v-if="shown"
        class="border-gray-500 rounded-xl border-2 my-16 note"
      >
        <BasicAndAddressBlock :user="user" />

        <FavoriteBlockList :user="user" />

        <QuestionBlockList :user="user" />

        <RankingBlockList :user="user" />

        <YesOrNoBlockList :user="user" />

        <TextBlockList :user="user" />
      </v-container>
      <ToTopButton />
    </div>
  </div>
</template>

<script>
// plugins
import axios from "axios";

// Component ----------
import BasicAndAddressBlock from "../../components/BasicAndAddressBlock";
import TextBlockList from "../../components/text_block/TextBlockList";
import QuestionBlockList from "../../components/question_block/QuestionBlockList";
import YesOrNoBlockList from "../../components/yes_or_no_block/YesOrNoBlockList";
import RankingBlockList from "../../components//ranking_block/RankingBlockList";
import FavoriteBlockList from "../../components/favorite_block/FavoriteBlockList";
import Loading from "../../components/shared/Loading";
import ToTopButton from "../../components/parts/ToTopButton";

export default {
  components: {
    BasicAndAddressBlock,
    QuestionBlockList,
    YesOrNoBlockList,
    RankingBlockList,
    TextBlockList,
    FavoriteBlockList,
    Loading,
    ToTopButton,
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
  beforeRouteUpdate(to, from, next) {
    // URL の id が変わったときにリソースを再読み込みする
    next();
    this.resetLoading();
    this.updateRead(to.params.id);
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
      profiles: [],
      profile: {},
      user: {},
      shown: false,
      loading: true,
    };
  },
  computed: {
    nextProfile() {
      const index = this.findProfileIndex + 1;
      if (index == this.totalProfilesNum) {
        return this.profiles[0];
      } else {
        return this.profiles[index];
      }
    },
    previousProfile() {
      const index = this.findProfileIndex - 1;
      if (index < 0) {
        return this.profiles[this.totalProfilesNum - 1];
      } else {
        return this.profiles[index];
      }
    },
    totalProfilesNum() {
      return this.profiles.length;
    },
    findProfileIndex() {
      return this.profiles.findIndex(
        (profile) => profile.public_uid == this.profile.public_uid
      );
    },
  },
  mounted() {
    setTimeout(() => {
      this.loading = false;
    }, 1000);
    this.firstRead();
  },
  created() {
    document.title = `プロフ閲覧 - プロフちゃん`;
  },
  methods: {
    async firstRead() {
      await this.fetchProfile(this.id);
      await this.fetchProfiles();
      await this.fetchUser();
      // これをしないと先に値を渡す前に子コンポーネントが読まれてしまう
      this.shown = true;
    },
    async updateRead(id) {
      await this.fetchProfile(id);
      await this.fetchProfiles();
      await this.fetchUser();
    },
    async fetchProfile(id) {
      await axios
        .get(`/api/v1/profiles/${id}`)
        .then((res) => (this.profile = res.data));
    },
    async fetchProfiles() {
      await axios
        .get(`/api/v1/profiles`)
        .then((res) => (this.profiles = res.data));
    },
    async fetchUser() {
      await axios
        .get(`/api/v1/users/${this.profile.user.id}`)
        .then((res) => (this.user = res.data));
    },
    moveToProfilesPage() {
      this.$router.push("/profiles").catch((err) => {});
    },
    moveToNextProfilePage(profile) {
      this.$router.push(`/profiles/${profile.public_uid}`).catch((err) => {});
    },
    resetLoading() {
      this.loading = true;
      setTimeout(() => {
        this.loading = false;
      }, 1000);
    },
  },
};
</script>

<style scoped>
.note {
  background: linear-gradient(rgb(255, 245, 245) 5px, transparent 0.6px) #fffbf2;
  background-size: auto 5em;
  border-top: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
  border-left: 1px solid #ccc;
  border-right: 1px solid #ccc;
  overflow: hidden;
}
</style>
