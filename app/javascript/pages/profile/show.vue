<!-- app/javascript/pages/profile/show.vue -->
<template>
  <div
    class="bg-backimage-02 bg-cover bg-fixed text-gray-600 font-prof-default"
  >
    <v-container>
      <p class="text-5xl font-bold note mb-10">
        {{ profile.user.name }} さんのプロフィール
      </p>
      <v-row class="mb-10">
        <v-col cols="12" sm="6">
          <BasicProfCard :profile="profile" />
          <v-btn
            id="edit-basic-profile-btn"
            v-show="isCurrentUser"
            @click="openEditBasicProfModal(profile)"
          >
            編集する
          </v-btn>
        </v-col>
      </v-row>
    </v-container>
    <v-row justify="space-around">
      <v-card-actions>
        <v-btn
          x-large
          color="light-green accent-2"
          class="font-prof-default black--text"
          @click="moveToProfilesPage"
        >
          <v-icon left> mdi-account-circle </v-icon>
          プロフィール閲覧
        </v-btn>
      </v-card-actions>
    </v-row>
    <EditBasicProfModal
      :is-shown-edit-basic-prof-modal="isShownEditBasicProfModal"
      :profile="profile"
      :user="profile.user"
      @update-basic-profile="updateBasicProfile"
      @close-basic-prof-modal="closeBasicProfModal"
    />
  </div>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions } from "vuex";

// Component ----------
import BasicProfCard from "../../components/BasicProfCard";
import EditBasicProfModal from "../../components/EditBasicProfModal";

export default {
  components: {
    BasicProfCard,
    EditBasicProfModal,
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
      user: {},
      isShownEditBasicProfModal: false,
    };
  },
  computed: {
    ...mapState("profiles", ["profiles"]),
    profile() {
      return this.profiles.find((profile) => profile.id == this.id) || {};
    },
    isCurrentUser() {
      return this.profile.user.id === this.user.id;
    },
  },
  created() {
    // [TODO: リファクタリング] axiosのモジュールに移すか考える
    this.$axios
      .get("/users/new")
      .then((response) => (this.user = response.data))
      .catch((err) => console.log(err.status));
  },
  mounted() {
    // [TODO: Refactor] ページごとにタイトルを変更(下記メソッドで実装)
    // document.title = `${ this.profile.user.name } - プロフちゃん`;
    document.title = `プロフィール詳細 - プロフちゃん`;
  },
  methods: {
    ...mapActions("profiles", ["patchProfile"]),
    moveToProfilesPage() {
      this.$router.push("/profiles");
    },
    openEditBasicProfModal(profile) {
      this.isShownEditBasicProfModal = true;
    },
    closeBasicProfModal() {
      this.isShownEditBasicProfModal = false;
    },
    updateBasicProfile(profile) {
      this.patchProfile(profile);
      this.closeBasicProfModal();
    },
  },
};
</script>

<style scoped></style>
