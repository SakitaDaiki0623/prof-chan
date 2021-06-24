<template>
  <div class="rounded-2xl">
    <v-card outlined color="brown lighten-4" class="py-5 px-10">
      <div class="top-sub-title text-2xl text-center">基本情報</div>
      <v-row>
        <v-col cols="12" sm="12" class="text-2xl">
          <v-row v-show="isThisEditPage" justify="end">
            <v-btn
              id="edit-basic-prof-card-button"
              tile
              small
              color="amber lighten-4"
              @click="openEditBasicProfCard"
            >
              <v-icon> mdi-pencil </v-icon>
            </v-btn>
          </v-row>
          <div class="pa-2 ma-2 bg-white rounded-full">
            <label for="birthday" class="form-label-text-block">性別</label>
            {{ profile.gender }}
          </div>

          <div class="pa-2 ma-2 bg-white rounded-full">
            <label for="birthday" class="form-label-text-block mr-2">身長</label
            >{{ profile.height }} cm
          </div>

          <div class="pa-2 ma-2 bg-white rounded-full">
            <label for="birthday" class="form-label-text-block mr-2">血液型</label
            >{{ profile.blood_type }} 型
          </div>

          <div class="pa-2 ma-2 bg-white rounded-full">
            <label for="birthday" class="form-label-text-block mr-2">出身地</label
            >{{ profile.prefecture_id }}
          </div>
          <div class="pa-2 ma-2 bg-white rounded-full">
            <label for="birthday" class="form-label-text-block">誕生日</label>
            {{ profile.birthday | moment }}
          </div>
          <div class="pa-2 ma-2 bg-white rounded-full">
            <label for="birthday" class="form-label-text-block">入社日</label>

            {{ profile.day_of_joinning | moment }}
          </div>
        </v-col>
      </v-row>
      <EditBasicProfCardDialog
        :is-shown-edit-basic-prof-card-dialog="isShownEditBasicProfCardDialog"
        :edit-basic-profile="editBasicProfile"
        @close-edit-basic-prof-card-dialog="closeEditBasicProfCardDialog"
        @update-profile="updateProfile"
      />
    </v-card>
  </div>
</template>

<script>
import axios from "axios";
import moment from "moment";

import EditBasicProfCardDialog from "./EditBasicProfCardDialog";

export default {
  filters: {
    moment: function (date) {
      return moment(date).format("YYYY/MM/DD");
    },
  },
  components: {
    EditBasicProfCardDialog,
  },
  props: {
    isThisEditPage: {
      type: Boolean,
      required: false,
      default: false,
    },
    user: {
      type: Object,
      required: false,
    },
  },
  data() {
    return {
      isShownEditBasicProfCardDialog: false,
      editBasicProfile: {},
      profile: {},
    };
  },
  computed: {},
  created() {
    this.firstRead();
  },
  methods: {
    openEditBasicProfCard() {
      this.editBasicProfile = Object.assign({}, this.profile);
      this.isShownEditBasicProfCardDialog = true;
    },
    closeEditBasicProfCardDialog() {
      this.isShownEditBasicProfCardDialog = false;
    },
    async firstRead() {
      this.getProfile();
    },
    async getProfile() {
      const profileRes = await axios.get(
        `/api/v1/profiles/${this.$route.params.id}`
      );
      const profile = profileRes.data;
      this.profile = profile;
    },
    updateProfile(result) {
      this.profile = result;
    },
  },
};
</script>

<style scoped></style>
