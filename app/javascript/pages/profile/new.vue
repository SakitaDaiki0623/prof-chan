<template>
  <div class="text-gray-600 font-prof-default">
    <div class="flex-grow">
      <div
        class="min-h-screen flex flex-col items-center justify-center bg-backimage bg-cover"
      >
        <h2 class="text-5xl mb-10">基本情報を入力してね♬</h2>
        <div class="w-3/5 bg-prof-card bg-cover shadow rounded-2xl">
          <div class="flex">
            <div class="w-full md:w-2/5 p-4 sm:p-6 lg:p-8">
              <div class="border-b-2 border-gray-600 inline-block text-3xl">
                ★基本情報★
              </div>
              <div class="w-full mt-10 ml-10">
                <img
                  class="rounded-full border-4 border-gray-600"
                  :src="user.image"
                />
              </div>
              <div class="text-2xl mt-5">名前</div>
              <div class="text-4xl border-b-2 border-gray-600 inline-block">
                {{ user.name }}
              </div>
            </div>
            <div class="md:w-3/5 p-8 lg:ml-4">
              <div class="p-6">
                <ProfileFormPane
                  @hundle-submit-basic-profile-info="openDialog"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <CreateProfileSuccessModal
      :isShownCreateProfileSuccessDialog="isShownCreateProfileSuccessDialog"
      v-show="isShownCreateProfileSuccessDialog"
    />
  </div>
</template>

<script>
import axios from "axios";
import ProfileFormPane from "../../components/forms/ProfileFormPane";
import CreateProfileSuccessModal from "../../components/CreateProfileSuccessModal";
import { mapActions } from "vuex";

export default {
  components: {
    ProfileFormPane,
    CreateProfileSuccessModal,
  },
  data() {
    return {
      user: {},
      team: {
        image: "",
      },
      profile: {
        height: "",
        gender: "",
        blood_type: "",
        prefecture_id: "",
        birthday: "",
        day_of_joinning: "",
      },
      errors: "",
      isShownCreateProfileSuccessDialog: false,
    };
  },
  created() {
    this.$axios
      .get("/profiles/new")
      .then((response) => (this.user = response.data))
      .catch((err) => console.log(err.status));
  },
  methods: {
    ...mapActions("profiles", ["createBasicProfile"]),
    submitBasicProfileInfo(profile) {
      // TODO: [FIX] リファクタリング
      if (
        profile.height == "" ||
        profile.gender == "" ||
        profile.blood_type == "" ||
        profile.prefecture_id == "" ||
        profile.birthday == "" ||
        profile.day_of_joinning == ""
      )
        return;
      this.createBasicProfile(profile);
      this.openDialog();
    },
    openDialog() {
      console.log("openDialog");
      this.isShownCreateProfileSuccessDialog = true;
    },
  },
};
</script>
