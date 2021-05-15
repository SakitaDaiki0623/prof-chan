<!-- app/javascript/pages/profile/index.vue -->
<template>
  <div class="bg-backimage bg-cover bg-fixed text-gray-600">
    <v-container class="note shadow-lg mb-20 mt-20">
      <p class="text-5xl font-bold pt-10 pb-10">
        社員プロフ一覧
      </p>
      <v-row class="mb-10">
        <v-col v-for="profile in profiles" :key="profile.id" cols="12" sm="4">
          <IndexProfCard :profile="profile" />
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import axios from "axios";
import { mapState, mapActions } from "vuex";

// Component ----------
import IndexProfCard from "../../components/IndexProfCard";

export default {
  components: {
    IndexProfCard,
  },
  data() {
    return {
      profiles: [],
    };
  },
  computed: {
    ...mapState("users", ["currentUser"]),
    ...mapState("textBlocks", ["textBlocks"]),
    ...mapState("rankingBlocks", ["rankingBlocks"]),
    ...mapState("yesOrNoBlocks", ["yesOrNoBlocks"]),
    ...mapState("yesOrNoBlocks", ["yesOrNoItems"]),
    ...mapState("questionBlocks", ["questionBlocks"]),
    ...mapState("questionBlocks", ["questionItems"]),
  },
  mounted() {
    document.title = "プロフ一覧 - プロフちゃん";
  },
  created() {
    this.firstRead();
  },
  methods: {
    async fetchProfiles() {
      await axios
        .get("/api/v1/profiles")
        .then((response) => (this.profiles = response.data));
    },
    async firstRead() {
      this.fetchProfiles();
    },
  },
};
</script>

<style scoped>
.note {
  width: 80%;
  padding: 0 1em;
  background: linear-gradient(#ccc 0.1px, transparent 0.6px) #fffbf2;
  background-size: auto 2.5em;
  line-height: 2.5em;
  border-bottom: 1px solid #ccc;
  border-left: 1px solid #ccc;
  border-right: 1px solid #ccc;
  overflow: hidden;
}
</style>
