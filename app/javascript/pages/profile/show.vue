<!-- app/javascript/pages/profile/show.vue -->
<template>
  <v-container class="border-gray-500 rounded-xl border-2 m-20 note">
    <BasicAndAddressBlock :user="user" />

    <FavoriteBlockList :user="user" />

    <QuestionBlockList :user="user" />

    <RankingBlockList :user="user" />

    <YesOrNoBlockList :user="user" />

    <TextBlockList :user="user" />
  </v-container>
</template>

<script>
// plugins
import axios from "axios";
import { mapState } from "vuex";

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
  computed: {
    ...mapState("users", ["users"]),

    user() {
      return this.users.find(
        (user) => this.$route.params.id == user.profile.public_uid
      );
    },
  },
  data() {
    return {
      profiles: [],
    };
  },
  mounted() {
    document.title = `プロフ詳細 - プロフちゃん`;
  },
  methods: {
    moveToProfilesPage() {
      this.$router.push("/profiles");
    },
  },
  beforeRouteEnter(to, from, next) {
    axios
      .get(`/api/v1/profiles/${to.params.id}`)
      .then((res) => next())
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
