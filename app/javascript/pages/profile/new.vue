<template>
  <div class="md:ma-10 mb-16">
    <v-row align-content="center" justify="center" >
      <v-col cols="12" sm="12" md="6" class="ma-5">
        <!-- Basic Info Card -->
        <v-card class="rounded-2xl" color="brown lighten-4" outlined>
          <div class="pa-10">
            <!-- FORM -->
            <div id="profile-basic-form" class="pa-6">
              <div class="top-sub-title text-2xl text-center">基本情報</div>
              <ValidationObserver ref="observer" v-slot="{ invalid }">
                <form @submit.prevent="hundleSubmitBasicProfileInfo(profile)">
                  <div>
                    <label class="form-label-text-block" for="profile_gender"
                      >性別</label
                    >
                    <ValidationProvider
                      v-slot="{ errors }"
                      name="性別"
                      rules="select_required"
                    >
                      <v-select
                        id="profile_gender"
                        v-model="profile.gender"
                        class="input-form-basic-block"
                        name="profile[gender]"
                        :items="genders"
                        item-text="text"
                        item-value="text"
                        color="brown lighten-3"
                        persistent-hint
                        single-line
                        autofocus
                      />
                      <span class="red--text text-sm">{{ errors[0] }}</span>
                    </ValidationProvider>
                  </div>
                  <div>
                    <label class="form-label-text-block" for="profile_height"
                      >身長(cm)</label
                    >
                    <ValidationProvider
                      v-slot="{ errors }"
                      name="身長"
                      rules="input_required|nurmeric_max:3"
                    >
                      <input
                        id="profile_height"
                        v-model="profile.height"
                        class="input-form-basic-block"
                        type="number"
                        name="profile[height]"
                      />
                      <span class="red--text text-sm">{{ errors[0] }}</span>
                    </ValidationProvider>
                  </div>
                  <div>
                    <label
                      class="form-label-text-block"
                      for="profile_blood_type"
                      >血液型</label
                    >
                    <ValidationProvider
                      v-slot="{ errors }"
                      name="血液型"
                      rules="select_required"
                    >
                      <v-select
                        id="profile_blood_type"
                        v-model="profile.blood_type"
                        class="input-form-basic-block"
                        name="profile[blood_type]"
                        :items="bloodTypes"
                        item-text="bloodTypes"
                        item-value="bloodTypes"
                        color="brown lighten-3"
                        persistent-hint
                        single-line
                      />
                      <span class="red--text text-sm">{{ errors[0] }}</span>
                    </ValidationProvider>
                  </div>
                  <div>
                    <label
                      class="form-label-text-block"
                      for="profile_prefecture_id"
                      >出身地</label
                    >
                    <ValidationProvider
                      v-slot="{ errors }"
                      name="出身地"
                      rules="select_required"
                    >
                      <v-select
                        id="profile_prefecture_id"
                        v-model="profile.prefecture_id"
                        name="profile[prefecture_id]"
                        class="input-form-basic-block"
                        :items="prefectures"
                        item-text="text"
                        item-value="text"
                        color="brown lighten-3"
                        persistent-hint
                        single-line
                      />
                      <span class="red--text text-sm">{{ errors[0] }}</span>
                    </ValidationProvider>
                  </div>
                  <div>
                    <label class="form-label-text-block" for="profile_birthday"
                      >生年月日</label
                    >
                    <v-menu
                      ref="menu"
                      v-model="birthMenu"
                      :close-on-content-click="false"
                      transition="scale-transition"
                      offset-y
                      min-width="auto"
                    >
                      <template #activator="{ on, attrs }">
                        <ValidationProvider
                          v-slot="{ errors }"
                          name="生年月日"
                          rules="input_required|available_age"
                        >
                          <input
                            id="profile_birthday"
                            v-model="profile.birthday"
                            type="date"
                            class="input-form-basic-block"
                            name="profile[birthday]"
                          />
                          <v-btn
                            v-bind="attrs"
                            v-on="on"
                            tile
                            small
                            color="brown"
                            class="white--text"
                          >
                            モーダルで入力する
                          </v-btn>
                          <span class="red--text text-sm">{{ errors[0] }}</span>
                        </ValidationProvider>
                      </template>
                      <v-date-picker
                        ref="picker"
                        v-model="profile.birthday"
                        color="brown darken-2"
                        header-color="brown darken-2"
                        locale="ja-jp"
                        :day-format="(date) => new Date(date).getDate()"
                        :max="maxDate"
                        :min="minDate"
                        @change="saveBirthDate"
                        year-icon="mdi-calendar-blank"
                        prev-icon="mdi-skip-previous"
                        next-icon="mdi-skip-next"
                      />
                    </v-menu>
                  </div>
                  <div>
                    <label
                      class="form-label-text-block"
                      for="profile_day_of_joinning"
                      >Slack参加日</label
                    >
                    <v-menu
                      ref="menu"
                      v-model="joinedMenu"
                      :close-on-content-click="false"
                      transition="scale-transition"
                      offset-y
                      min-width="auto"
                    >
                      <template #activator="{ on, attrs }">
                        <ValidationProvider
                          v-slot="{ errors }"
                          name="Slack参加日"
                          rules="input_required"
                        >
                          <input
                            id="profile_day_of_joinning"
                            v-model="profile.day_of_joinning"
                            type="date"
                            name="profile[day_of_joinning]"
                            class="input-form-basic-block"
                          />
                          <v-btn
                            v-bind="attrs"
                            v-on="on"
                            tile
                            small
                            color="brown"
                            class="white--text"
                          >
                            モーダルで入力する
                          </v-btn>
                          <span class="red--text text-sm">{{ errors[0] }}</span>
                        </ValidationProvider>
                      </template>
                      <v-date-picker
                        ref="picker"
                        v-model="profile.day_of_joinning"
                        color="brown darken-2"
                        header-color="brown darken-2"
                        locale="ja-jp"
                        :day-format="(date) => new Date(date).getDate()"
                        @change="saveJoinedDate"
                        year-icon="mdi-calendar-blank"
                        prev-icon="mdi-skip-previous"
                        next-icon="mdi-skip-next"
                      />
                    </v-menu>
                  </div>
                  <div class="text-center mt-3">
                    <v-btn
                      id="creation_button"
                      type="submit"
                      depressed
                      elevation="4"
                      x-large
                      :disabled="invalid"
                      color="brown"
                      class="white--text"
                    >
                      入力完了！
                    </v-btn>
                  </div>
                </form>
              </ValidationObserver>
            </div>
            <!-- /FORM -->
          </div> </v-card
        ><!-- Basic Info Card -->
      </v-col>
    </v-row>
    <CreateProfileSuccessModal
      :is-shown-create-profile-success-dialog="
        isShownCreateProfileSuccessDialog
      "
    />
  </div>
</template>

<script>
import axios from "axios";
import { mapState, mapActions } from "vuex";

import CreateProfileSuccessModal from "../../components/others/CreateProfileSuccessModal";

export default {
  components: {
    CreateProfileSuccessModal,
  },
  data() {
    return {
      team: {
        image: "",
      },
      profile: {
        height: "",
        gender: "",
        blood_type: "",
        prefecture_id: "",
        birthday: "2000",
        day_of_joinning: "",
      },
      date: null,
      birthMenu: false,
      joinedMenu: false,
      isShownCreateProfileSuccessDialog: false,

      genders: [
        { text: "男性", value: "male" },
        { text: "女性", value: "female" },
      ],
      bloodTypes: ["A", "B", "AB", "O"],
    };
  },
  computed: {
    ...mapState("users", ["currentUser"]),
    ...mapState("activeHash", ["prefectures"]),

    user() {
      return this.currentUser;
    },
    maxDate() {
      let dt = new Date();
      dt.setFullYear(dt.getFullYear() - 18);
      return dt.toISOString().substr(0, 10);
    },
    minDate() {
      let dt = new Date();
      dt.setFullYear(dt.getFullYear() - 70);
      return dt.toISOString().substr(0, 10);
    },
  },
  watch: {
    menu(val) {
      val && setTimeout(() => (this.$refs.picker.activePicker = "YEAR"));
    },
  },
  mounted() {
    document.title = "プロフづくり - プロフちゃん";
  },
  created() {
    this.fetchCurrentUser();
  },
  methods: {
    ...mapActions("users", ["fetchCurrentUser"]),
    hundleSubmitBasicProfileInfo(profile) {
      // genderの変換
      if (profile.gender == "男性") {
        profile.gender = "male";
      } else {
        profile.gender = "female";
      }

      // prefecture_idの変換
      const selectedPrefecture = this.prefectures.find(
        (prefecture) => prefecture.text == profile.prefecture_id
      );
      profile.prefecture_id = selectedPrefecture.value;
      this.createBasicProfile(profile);
      this.openDialog();
    },
    openDialog() {
      this.isShownCreateProfileSuccessDialog = true;
      this.fetchCurrentUser(); // currentUserの更新
    },
    saveBirthDate(date) {
      this.$refs.menu.save(date);
    },
    saveJoinedDate(date) {
      this.$refs.menu.save(date);
    },
    async createBasicProfile() {
      await axios.post("/api/v1/profiles", this.profile);
    },
  },
};
</script>

<style scoped>
input[type="time"]::-webkit-calendar-picker-indicator {
  display: none;
}

input[type="date"]::-webkit-calendar-picker-indicator {
  display: none;
}

.note {
  width: 500px;
  padding: 0 1em;
  background: linear-gradient(#ccc 1px, transparent 1px) #fffbf2;
  background-size: auto 2.5em;
  line-height: 2.5em;
  border-bottom: 1px solid #ccc;
  border-left: 1px solid #ccc;
  border-right: 1px solid #ccc;
  overflow: hidden;
}

.balloon1:before {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -15px;
  border: 15px solid transparent;
  border-top: 15px solid #e0edff;
}
</style>
