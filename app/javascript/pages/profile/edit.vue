<!-- app/javascript/pages/profile/show.vue -->
<!-- TODO: 編集画面は後ほど削除予定 -->
<template>
  <div
    class="bg-backimage-02 bg-cover bg-fixed text-gray-600 font-prof-default"
  >
    <v-container>
      <p class="text-5xl font-bold note mb-10">
        プロフィール編集
      </p>
      <v-row class="mb-10">
        <v-col
          cols="12"
          sm="6"
        >
          <EditBasicProfCard :profile="profile" />
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
// plugins
import axios from "axios";
import { mapState } from "vuex";

// Component ----------
import EditBasicProfCard from "../../components/EditBasicProfCard";

export default {
  components: {
    EditBasicProfCard,
  },
  props: {
    id: {
      type: String,
      require: true,
      default: "",
    },
  },
  data() {
    return {};
  },
  computed: {
    ...mapState("profiles", ["profiles"]),
    profile() {
      return this.profiles.find((profile) => profile.id == this.id) || {};
    },
  },
  mounted() {
    document.title = `プロフィール編集 - プロフちゃん`;
  },
  methods: {
    moveToProfilesPage() {
      this.$router.push("/profiles");
    },
  },
};
</script>

<style scoped></style>
