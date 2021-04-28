<!-- app/javascript/pages/profile/edit.vue -->
<template>
  <div class="text-gray-600">
    <p class="text-5xl font-bold note mb-10">プロフィール編集</p>

    <BasicAndAddressBlock :is-this-edit-page="isThisEditPage" />

    <MyFavoriteBlock :is-this-edit-page="isThisEditPage" />

    <TextBlockList :is-this-edit-page="isThisEditPage" />

    <QuestionBlockList :is-this-edit-page="isThisEditPage" />

    <YesOrNoBlockList :is-this-edit-page="isThisEditPage" />

    <RankingBlockList :is-this-edit-page="isThisEditPage" />
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
      user: {},
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
    isThisEditPage() {
      return this.$route.path == `/profiles/${this.profile.id}/edit`
        ? true
        : false;
    },
  },
  created() {
    this.firstRead();
    document.title = `プロフィール編集 - プロフちゃん`;
  },
  methods: {
    ...mapActions({
      fetchProfiles: "profiles/fetchProfiles",
      fetchCurrentUser: "users/fetchCurrentUser",
    }),
    async firstRead() {
      this.getProfile();
    },
    async getProfile() {
      const profileRes = await axios.get(
        `/api/v1/profiles/${this.$route.params.id}`
      );
      const profile = profileRes.data;
      this.profile = profile;
      this.getUser();
    },
    async getUser() {
      await axios
        .get(`/api/v1/users/${this.profile.user.id}`)
        .then((response) => (this.user = response.data));
    },
  },
};
</script>
