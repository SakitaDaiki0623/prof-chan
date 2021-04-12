<template>
  <div class="text-gray-600 font-prof-default">
    <div class="flex-grow">
      <div
        class="min-h-screen flex flex-col items-center justify-center bg-backimage bg-cover bg-fixed"
      >
        <h2 class="text-5xl mb-10">
          基本情報を入力してね♬
        </h2>
        <div class="w-3/5 shadow rounded-2xl bg-prof-card">
          <div class="flex">
            <div class="w-full md:w-2/5 p-4 sm:p-6 lg:p-8">
              <div
                class="border-b-2 border-gray-600 inline-block text-3xl mt-10 ml-10 border-4 border-gray-300"
              >
                ★基本情報★
              </div>
              <div class="w-full mt-10 ml-10">
                <img
                  class="ring-4 ring-gray-600	"
                  :src="user.image"
                >
              </div>
              <div class="ml-8">
                <div class="text-2xl mt-5">
                  名前
                </div>
                <div
                  class="text-4xl pb-2 border-b-2 border-gray-600 inline-block font-bold"
                >
                  {{ user.name }}
                </div>
              </div>
            </div>
            <div class="md:w-3/5 p-8 lg:ml-4">
              <!-- FORM -->
              <div
                id="profile-basic-form"
                class="p-6"
              >
                <ValidationObserver
                  ref="observer"
                  v-slot="{ invalid }"
                >
                  <form @submit.prevent="hundleSubmitBasicProfileInfo(profile)">
                    <div>
                      <label
                        class="form-label"
                        for="profile_gender"
                      >性別</label>
                      <ValidationProvider
                        v-slot="{ errors }"
                        name="性別"
                        rules="select_required"
                      >
                        <select
                          id="profile_gender"
                          v-model="profile.gender"
                          class="input-form"
                          name="profile[gender]"
                        >
                          <option value="male">
                            男性
                          </option>
                          <option value="female">
                            女性
                          </option>
                        </select>
                        <span class="text-red-400">{{ errors[0] }}</span>
                      </ValidationProvider>
                    </div>
                    <div>
                      <label
                        class="form-label"
                        for="profile_height"
                      >身長</label>
                      <ValidationProvider
                        v-slot="{ errors }"
                        name="身長"
                        rules="input_required"
                      >
                        <input
                          id="profile_height"
                          v-model="profile.height"
                          class="input-form"
                          type="number"
                          name="profile[height]"
                        >
                        <span class="text-red-400">{{ errors[0] }}</span>
                      </ValidationProvider>
                    </div>
                    <div>
                      <label
                        class="form-label"
                        for="profile_blood_type"
                      >血液型</label>
                      <ValidationProvider
                        v-slot="{ errors }"
                        name="血液型"
                        rules="select_required"
                      >
                        <select
                          id="profile_blood_type"
                          v-model="profile.blood_type"
                          class="input-form"
                          name="profile[blood_type]"
                        >
                          <option value="A">
                            A型
                          </option>
                          <option value="B">
                            B型
                          </option>
                          <option value="AB">
                            AB型
                          </option>
                          <option value="O">
                            O型
                          </option>
                        </select>
                        <span class="text-red-400">{{ errors[0] }}</span>
                      </ValidationProvider>
                    </div>
                    <div>
                      <label
                        class="form-label"
                        for="profile_prefecture_id"
                      >出身地</label>
                      <ValidationProvider
                        v-slot="{ errors }"
                        name="出身地"
                        rules="select_required"
                      >
                        <select
                          id="profile_prefecture_id"
                          v-model="profile.prefecture_id"
                          name="profile[prefecture_id]"
                          class="input-form"
                        >
                          <option
                            v-for="prefecture in prefectures"
                            :key="prefecture.value"
                            :value="prefecture.value"
                          >
                            {{ prefecture.text }}
                          </option>
                        </select>
                        <span class="text-red-400">{{ errors[0] }}</span>
                      </ValidationProvider>
                    </div>
                    <div>
                      <v-menu
                        ref="menu"
                        v-model="birthMenu"
                        :close-on-content-click="false"
                        transition="scale-transition"
                        offset-y
                        min-width="auto"
                      >
                        <template #activator="{ on, attrs }">
                          <!-- TODO: 入力値のフォーマットを設定 -->
                          <ValidationProvider
                            v-slot="{ errors }"
                            name="生年月日"
                            rules="input_required"
                          >
                            <v-text-field
                              id="profile_birthday"
                              v-model="profile.birthday"
                              name="profile[birthday]"
                              label="生年月日"
                              v-bind="attrs"
                              v-on="on"
                            />
                            <span class="text-red-400">{{ errors[0] }}</span>
                          </ValidationProvider>
                        </template>
                        <v-date-picker
                          ref="picker"
                          v-model="profile.birthday"
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
                      <v-menu
                        ref="menu"
                        v-model="joinedMenu"
                        :close-on-content-click="false"
                        transition="scale-transition"
                        offset-y
                        min-width="auto"
                      >
                        <template #activator="{ on, attrs }">
                          <!-- TODO: 入力値のフォーマットを設定 -->
                          <ValidationProvider
                            v-slot="{ errors }"
                            name="入社日"
                            rules="input_required"
                          >
                            <v-text-field
                              id="profile_day_of_joinning"
                              v-model="profile.day_of_joinning"
                              name="profile[day_of_joinning]"
                              label="入社日"
                              v-bind="attrs"
                              v-on="on"
                            />
                            <span class="text-red-400">{{ errors[0] }}</span>
                          </ValidationProvider>
                        </template>
                        <v-date-picker
                          ref="picker"
                          v-model="profile.day_of_joinning"
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
                        color="blue-grey darken-2"
                        class="white--text"
                      >
                        入力完了！
                      </v-btn>
                    </div>
                  </form>
                </ValidationObserver>
              </div>
              <!-- /FORM -->
            </div>
          </div>
        </div>
      </div>
    </div>
    <CreateProfileSuccessModal
      v-show="isShownCreateProfileSuccessDialog"
      :is-shown-create-profile-success-dialog="
        isShownCreateProfileSuccessDialog
      "
    />
  </div>
</template>

<script>
import axios from "axios";
import { mapActions } from "vuex";

// Component ----------
import CreateProfileSuccessModal from "../../components/CreateProfileSuccessModal";

export default {
  components: {
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
      date: null,
      birthMenu: false,
      joinedMenu: false,
      isShownCreateProfileSuccessDialog: false,
      prefectures: [
        { text: "北海道", value: "1" },
        { text: "青森県", value: "2" },
        { text: "岩手県", value: "3" },
        { text: "宮城県", value: "4" },
        { text: "秋田県", value: "5" },
        { text: "山形県", value: "6" },
        { text: "福島県", value: "7" },
        { text: "茨城県", value: "8" },
        { text: "栃木県", value: "9" },
        { text: "群馬県", value: "10" },
        { text: "埼玉県", value: "11" },
        { text: "千葉県", value: "12" },
        { text: "東京都", value: "13" },
        { text: "神奈川県", value: "14" },
        { text: "新潟県", value: "15" },
        { text: "富山県", value: "16" },
        { text: "石川県", value: "17" },
        { text: "福井県", value: "18" },
        { text: "山梨県", value: "19" },
        { text: "長野県", value: "20" },
        { text: "岐阜県", value: "21" },
        { text: "静岡県", value: "22" },
        { text: "愛知県", value: "23" },
        { text: "三重県", value: "24" },
        { text: "滋賀県", value: "25" },
        { text: "京都府", value: "26" },
        { text: "大阪府", value: "27" },
        { text: "兵庫県", value: "28" },
        { text: "奈良県", value: "29" },
        { text: "和歌山県", value: "30" },
        { text: "鳥取県", value: "31" },
        { text: "島根県", value: "32" },
        { text: "岡山県", value: "33" },
        { text: "広島県", value: "34" },
        { text: "山口県", value: "35" },
        { text: "徳島県", value: "36" },
        { text: "香川県", value: "37" },
        { text: "愛媛県", value: "38" },
        { text: "高知県", value: "39" },
        { text: "福岡県", value: "40" },
        { text: "佐賀県", value: "41" },
        { text: "長崎県", value: "42" },
        { text: "熊本県", value: "43" },
        { text: "大分県", value: "44" },
        { text: "宮崎県", value: "45" },
        { text: "鹿児島県", value: "46" },
        { text: "沖縄県", value: "47" },
      ],
    };
  },
  watch: {
    menu(val) {
      val && setTimeout(() => (this.$refs.picker.activePicker = "YEAR"));
    },
  },
  mounted() {
    document.title = "プロフィールづくり - プロフちゃん";
  },
  created() {
    // [TODO: リファクタリング] axiosのモジュールに移すか考える
    this.$axios
      .get("/users/new")
      .then((response) => (this.user = response.data))
      .catch((err) => console.log(err.status));
  },
  methods: {
    ...mapActions("profiles", ["createBasicProfile"]),
    hundleSubmitBasicProfileInfo(profile) {
      // [TODO: リファクタリング] メソッドが冗長なのでリファクタリングできるか考える
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
      this.isShownCreateProfileSuccessDialog = true;
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
