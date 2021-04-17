<!-- app/javascript/pages/profile/index.vue -->
<template>
  <div class="bg-backimage bg-cover bg-fixed text-gray-600 font-prof-default">
    <v-container class="note shadow-lg mb-20 mt-20">
      <p class="text-5xl font-bold pt-10 pb-10">
        社員プロフィール一覧
      </p>
      <v-row class="mb-10">
        <v-col
          v-for="profile in getProfiles"
          :key="profile.id"
          cols="12"
          sm="4"
        >
          <IndexProfCard :profile="profile" />
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import axios from "axios";
import { mapState, mapGetters, mapActions } from "vuex";

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
    ...mapGetters("profiles", ["getProfiles"]),
  },
  mounted() {
    document.title = "プロフィール一覧 - プロフちゃん";
  },
  created() {
    this.fetchCurrentUser();
    this.fetchProfiles();
  },
  methods: {
    ...mapActions("profiles", ["fetchProfiles"]),
    ...mapActions("users", ["fetchCurrentUser"]),
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
