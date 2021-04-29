<!-- app/javascript/pages/profile/edit.vue -->
<template>
  <div class="text-gray-600">
    <p class="text-5xl font-bold note mb-10">プロフィール編集</p>

    <BasicAndAddressBlock :is-this-edit-page="isThisEditPage" :user="user" />

    <MyFavoriteBlock :is-this-edit-page="isThisEditPage" :user="user" />

    <TextBlockList :is-this-edit-page="isThisEditPage" :user="user" />

    <QuestionBlockList :is-this-edit-page="isThisEditPage" :user="user" />

    <YesOrNoBlockList :is-this-edit-page="isThisEditPage" :user="user" />

    <RankingBlockList :is-this-edit-page="isThisEditPage" :user="user" />
  </div>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions } from "vuex";

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
  data() {
    return {
      profile: {},
    };
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
    isThisEditPage() {
      return this.$route.path == `/profiles/${this.user.profile.id}/edit`
        ? true
        : false;
    },
    user() {
      return this.users.find(
        (user) => this.$route.params.id == user.profile.id
      );
    },
  },
  created() {
    document.title = `プロフィール編集 - プロフちゃん`;
  },
  methods: {
    ...mapActions({
      fetchProfiles: "profiles/fetchProfiles",
      fetchCurrentUser: "users/fetchCurrentUser",
    }),
  },
};
</script>
