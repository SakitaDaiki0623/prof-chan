<template>
  <div class="rounded-2xl">
    <v-card outlined color="amber lighten-5" class="py-5 px-10">
      <v-row>
        <v-col cols="12" sm="6">
          <div class="border-b-2 border-gray-600 border-4 mb-3 text-center">
            ★基本情報★
          </div>
          <div>
            <v-img
              class="ring-4 ring-gray-600"
              :src="user.image"
              max-height="205px"
            />
          </div>
          <div>
            <div
              class="p-3 text-2xl font-bold text-gray-600 border-dotted	border-b-2 border-gray-400"
            >
              <label for="name" class="form-label-text-block">名前</label>
              <span class="name-text">{{ user.name }}</span>
            </div>
          </div>
        </v-col>
        <v-col cols="12" sm="6">
          <v-row justify="end" v-show="isThisEditPage">
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
          <div class="p-3 border-dotted	border-b-2 border-gray-400">
            <label for="birthday" class="form-label-text-block">性別</label>
            {{ profile.gender }}
          </div>

          <div class="p-3 border-dotted	border-b-2 border-gray-400">
            <label for="birthday" class="form-label-text-block">身長</label
            >{{ profile.height }} cm
          </div>

          <div class="p-3 border-dotted	border-b-2 border-gray-400">
            <label for="birthday" class="form-label-text-block">血液型</label
            >{{ profile.blood_type }} 型
          </div>

          <div class="p-3 border-dotted	border-b-2 border-gray-400">
            <label for="birthday" class="form-label-text-block">出身地</label
            >{{ profile.prefecture_id }}
          </div>
          <div class="p-3 border-dotted	border-b-2 border-gray-400">
            <label for="birthday" class="form-label-text-block">誕生日</label>
            {{ profile.birthday | moment }}
          </div>
          <div class="p-3 border-dotted	border-b-2 border-gray-400">
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
    moment: function(date) {
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
  created() {
    this.firstRead();
  },
  computed: {},
  methods: {
    openEditBasicProfCard() {
      this.editBasicProfile = this.profile;
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
