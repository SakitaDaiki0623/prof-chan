<!-- app/javascript/pages/profile/show.vue -->
<template>
  <v-container class="text-gray-600">
    <p class="text-5xl font-bold note mb-10">{{ user.name }}さんのプロフ</p>
    <BasicAndAddressBlock :user="user" />

    <MyFavoriteBlock :user="user" />

    <TextBlockList :user="user" />

    <QuestionBlockList :user="user" />

    <YesOrNoBlockList :user="user" />

    <RankingBlockList :user="user" />
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

export default {
  components: {
    BasicAndAddressBlock,
    MyFavoriteBlock,
    QuestionBlockList,
    YesOrNoBlockList,
    RankingBlockList,
    TextBlockList,
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
      profile: {},
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
};
</script>

<style scoped></style>
