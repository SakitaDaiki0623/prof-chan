<!-- app/javascript/pages/profile/show.vue -->
<template>
  <v-container
    class="border-gray-500 rounded-xl border-2 m-20 bg-main-contain-color"
  >
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
      profile: {},
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
    next((vm) => {
      const users = vm.users;
      const profileUser = users.find(
        (user) => to.params.id == user.profile.public_uid
      );
      if (profileUser == undefined) {
        vm.$store.dispatch("isNotFound/setIsNotFound", {
          boolean: true,
        });
      }
    });
  },
};
</script>

<style scoped>
.bg-main-contain-color {
  background-color: #f1fcdf;
}
</style>
