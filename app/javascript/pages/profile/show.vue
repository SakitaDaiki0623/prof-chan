<!-- app/javascript/pages/profile/show.vue -->
<template>
  <v-container class="text-gray-600">
    <p class="text-5xl font-bold note mb-10">
      {{ currentUser.name }}さんのプロフィール
    </p>
    <BasicAndAddressBlock />

    <MyFavoriteBlock />

    <TextBlockList />

    <QuestionBlockList />

    <YesOrNoBlockList />

    <RankingBlockList />
  </v-container>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions } from "vuex";

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
  created() {
    console.log(this.$route.path);
  },
  data() {
    return {};
  },
  computed: {
    ...mapState("profiles", ["profiles"]),
    ...mapState("users", ["currentUser"]),
    ...mapState("textBlocks", ["textBlocks"]),

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

<style scoped></style>
