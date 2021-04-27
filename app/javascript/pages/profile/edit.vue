<!-- app/javascript/pages/profile/edit.vue -->
<template>
  <div class="text-gray-600">
    <p class="text-5xl font-bold note mb-10">プロフィール編集</p>

    <BasicAndAddressBlock />

    <MyFavoriteBlock />

    <TextBlockList />

    <QuestionBlockList />

    <YesOrNoBlockList />

    <RankingBlockList />
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
  props: {
    id: {
      type: String,
      require: true,
      default: "",
    },
  },
  computed: {
  },
  created() {
    // this.fetchProfiles();
    // this.fetchCurrentUser();

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
