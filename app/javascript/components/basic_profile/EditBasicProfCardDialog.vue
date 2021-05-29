<!-- app/javascript/components/basic_profile/EditBasicProfCardDialog.vue -->
<template>
  <v-dialog
    :value="isShownEditBasicProfCardDialog"
    max-width="450"
    persistent
    @input="$emit('input', $event.target.isShownEditBasicProfCardDialog)"
  >
    <!-- Basic Info Card -->
    <v-card
      id="edit-basic-prof-card-dialog"
      class="shadow rounded-2xl py-5 px-10"
      color="brown lighten-4"
    >
      <div class="top-sub-title text-2xl text-center">
        基本情報
      </div>
      <v-row>
        <v-col cols="12" sm="12" class="text-2xl">
          <v-row justify="end">
            <v-btn
              id="cancel-basic-prof-card-button"
              tile
              small
              color="red lighten-4"
              @click="hundleCloseEditBasicProfCardDialog"
            >
              <v-icon> mdi-close-outline </v-icon>
            </v-btn>
          </v-row>
          <!-- FORM -->
          <div id="profile-basic-form" class="pa-6">
            <ValidationObserver ref="observer" v-slot="{ invalid }">
              <form
                @submit.prevent="hundleUpdateBasicProfile(editBasicProfile)"
              >
                <div>
                  <label class="form-label-text-block" for="profile_gender"
                    >性別</label
                  >
                  <ValidationProvider
                    v-slot="{ errors }"
                    name="性別"
                    rules="select_required"
                  >
                    <select
                      id="profile_gender"
                      v-model="editBasicProfile.gender"
                      class="input-form-basic-block"
                      name="profile[gender]"
                    >
                      <option
                        v-for="gender in genders"
                        :key="gender.value"
                        :value="gender.text"
                      >
                        {{ gender.text }}
                      </option>
                    </select>
                    <span class="red--text text-sm">{{ errors[0] }}</span>
                  </ValidationProvider>
                </div>
                <div>
                  <label class="form-label-text-block" for="profile_height"
                    >身長</label
                  >
                  <ValidationProvider
                    v-slot="{ errors }"
                    name="身長"
                    rules="input_required"
                  >
                    <input
                      id="profile_height"
                      v-model="editBasicProfile.height"
                      class="input-form-basic-block"
                      type="number"
                      name="profile[height]"
                    />
                    <span class="red--text text-sm">{{ errors[0] }}</span>
                  </ValidationProvider>
                </div>
                <div>
                  <label class="form-label-text-block" for="profile_blood_type"
                    >血液型</label
                  >
                  <ValidationProvider
                    v-slot="{ errors }"
                    name="血液型"
                    rules="select_required"
                  >
                    <select
                      id="profile_blood_type"
                      v-model="editBasicProfile.blood_type"
                      class="input-form-basic-block"
                      name="profile[blood_type]"
                    >
                      <option
                        v-for="bloodType in bloodTypes"
                        :key="bloodType"
                        :value="bloodType"
                      >
                        {{ bloodType }}型
                      </option>
                    </select>
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
                    <select
                      id="profile_prefecture_id"
                      v-model="editBasicProfile.prefecture_id"
                      name="profile[prefecture_id]"
                      class="input-form-basic-block"
                    >
                      <option
                        v-for="prefecture in prefectures"
                        :key="prefecture.value"
                        :value="prefecture.text"
                      >
                        {{ prefecture.text }}
                      </option>
                    </select>
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
                        rules="input_required"
                      >
                        <input
                          id="profile_birthday"
                          v-model="editBasicProfile.birthday"
                          type="date"
                          class="input-form-basic-block"
                          name="profile[birthday]"
                          v-bind="attrs"
                          v-on="on"
                        />
                        <span class="red--text text-sm">{{ errors[0] }}</span>
                      </ValidationProvider>
                    </template>
                    <v-date-picker
                      ref="picker"
                      v-model="editBasicProfile.birthday"
                      color="blue-grey darken-3"
                      header-color="blue-grey darken-2"
                      locale="ja-jp"
                      :day-format="(date) => new Date(date).getDate()"
                      :max="new Date().toISOString().substr(0, 10)"
                      min="1950-01-01"
                      @change="saveBirthDate"
                    />
                  </v-menu>
                </div>
                <div>
                  <label
                    class="form-label-text-block"
                    for="profile_day_of_joinning"
                    >入社日</label
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
                        name="入社日"
                        rules="input_required"
                      >
                        <input
                          id="profile_day_of_joinning"
                          v-model="editBasicProfile.day_of_joinning"
                          type="date"
                          name="profile[day_of_joinning]"
                          v-bind="attrs"
                          class="input-form-basic-block"
                          v-on="on"
                        />
                        <span class="red--text text-sm">{{ errors[0] }}</span>
                      </ValidationProvider>
                    </template>
                    <v-date-picker
                      ref="picker"
                      v-model="editBasicProfile.day_of_joinning"
                      color="blue-grey darken-3"
                      header-color="blue-grey darken-2"
                      locale="ja-jp"
                      :day-format="(date) => new Date(date).getDate()"
                      @change="saveJoinedDate"
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
                    color="brown lighten-2"
                    class="white--text"
                  >
                    基本情報を更新！
                  </v-btn>
                </div>
              </form>
            </ValidationObserver>
          </div>
          <!-- /FORM -->
        </v-col>
      </v-row>
    </v-card>
    <!-- Basic Info Card -->
  </v-dialog>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions } from "vuex";

// components ----------

export default {
  props: {
    isShownEditBasicProfCardDialog: {
      type: Boolean,
      required: true,
    },
    editBasicProfile: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      date: null,
      birthMenu: false,
      joinedMenu: false,
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
  },
  methods: {
    patchProfile: async function() {
      const res = await axios.patch(
        `/api/v1/profiles/${this.editBasicProfile.public_uid}`,
        this.editBasicProfile
      );
      if (res.status !== 200) {
        process.exit();
      }
      return res.data;
    },
    hundleUpdateBasicProfile(editBasicProfile) {
      // genderの変換
      if (editBasicProfile.gender == "男性") {
        editBasicProfile.gender = "male";
      } else {
        editBasicProfile.gender = "female";
      }

      // prefecture_idの変換
      const selectedPrefecture = this.prefectures.find(
        (prefecture) => prefecture.text == editBasicProfile.prefecture_id
      );
      editBasicProfile.prefecture_id = selectedPrefecture.value;

      this.patchProfile().then((result) => {
        this.$emit("update-profile", result);
      });
      this.hundleCloseEditBasicProfCardDialog();
    },
    hundleCloseEditBasicProfCardDialog() {
      this.$emit("close-edit-basic-prof-card-dialog");
    },
    saveBirthDate(date) {
      this.$refs.menu.save(date);
    },
    saveJoinedDate(date) {
      this.$refs.menu.save(date);
    },
  },
};
</script>
