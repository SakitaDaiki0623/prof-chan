<!-- app/javascript/pages/profile/edit.vue -->
<template>
  <v-container
    class="border-gray-500 border-dashed rounded-xl border-2 m-20 bg-main-contain-color"
  >
    <div class="text-5xl font-bold p-10 text-gray-600 rounded-t-2xl">
      プロフ編集
    </div>

    <v-container>
      <BasicAndAddressBlock :is-this-edit-page="isThisEditPage" :user="user" />

      <MyFavoriteBlock :is-this-edit-page="isThisEditPage" :user="user" />

      <TextBlockList :is-this-edit-page="isThisEditPage" :user="user" />

      <QuestionBlockList :is-this-edit-page="isThisEditPage" :user="user" />

      <YesOrNoBlockList :is-this-edit-page="isThisEditPage" :user="user" />

      <RankingBlockList :is-this-edit-page="isThisEditPage" :user="user" />
    </v-container>
  </v-container>
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
  data() {
    return {
      profile: {},
    };
  },
  computed: {
    ...mapState("users", ["users"]),
    isThisEditPage() {
      return this.$route.path == `/profiles/${this.user.profile.public_uid}/edit`
        ? true
        : false;
    },
    user() {
      return this.users.find(
        (user) => this.$route.params.id == user.profile.public_uid
      );
    },
  },
  created() {
    document.title = `プロフ編集 - プロフちゃん`;
  },
  methods: {
    ...mapActions({
      fetchProfiles: "profiles/fetchProfiles",
      fetchCurrentUser: "users/fetchCurrentUser",
    }),
  },
};
</script>

<style>
.bg-main-contain-color {
  background-color: #fdfff2;
}

.dot-color {
  color: #fffaf0;
  letter-spacing: 5rem;
}


.list-enter-active,
.list-leave-active,
.list-move {
  transition: 500ms cubic-bezier(0.59, 0.12, 0.34, 0.95);
  transition-property: opacity, transform;
}

.list-enter {
  opacity: 0;
  transform: translateX(50px) scaleY(0.5);
}

.list-enter-to {
  opacity: 1;
  transform: translateX(0) scaleY(1);
}

.list-leave-active {
  position: absolute;
}

.list-leave-to {
  opacity: 0;
  transform: scaleY(0);
  transform-origin: center top;
}
</style>
