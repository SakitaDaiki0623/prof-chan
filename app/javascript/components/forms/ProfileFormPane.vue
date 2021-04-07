<template>
  <ValidationObserver ref="observer" v-slot="{ invalid }">
    <form @submit.prevent="hundleSubmitBasicProfileInfo">
      <div>
        <label class="form-label" for="profile_gender">性別</label>
        <ValidationProvider
          v-slot="{ errors }"
          name="性別"
          rules="select_required"
        >
          <select
            class="input-form"
            name="profile[gender]"
            id="profile_gender"
            v-model="profile.gender"
          >
            <option value="male">男性</option>
            <option value="female">女性</option>
          </select>
          <span class="text-red-400">{{ errors[0] }}</span>
        </ValidationProvider>
      </div>
      <div>
        <label class="form-label" for="profile_height">身長</label>
        <ValidationProvider
          v-slot="{ errors }"
          name="身長"
          rules="input_required"
        >
          <input
            class="input-form"
            type="number"
            name="profile[height]"
            id="profile_height"
            v-model="profile.height"
          />
          <span class="text-red-400">{{ errors[0] }}</span>
        </ValidationProvider>
      </div>
      <div>
        <label class="form-label" for="profile_blood_type">血液型</label>
        <ValidationProvider
          v-slot="{ errors }"
          name="血液型"
          rules="select_required"
        >
          <select
            class="input-form"
            name="profile[blood_type]"
            id="profile_blood_type"
            v-model="profile.blood_type"
          >
            <option value="A">A型</option>
            <option value="B">B型</option>
            <option value="AB">AB型</option>
            <option value="O">O型</option>
          </select>
          <span class="text-red-400">{{ errors[0] }}</span>
        </ValidationProvider>
      </div>
      <div>
        <label class="form-label" for="profile_prefecture_id">出身地</label>
        <ValidationProvider
          v-slot="{ errors }"
          name="出身地"
          rules="select_required"
        >
          <select
            name="profile[prefecture_id]"
            id="profile_prefecture_id"
            class="input-form"
            v-model="profile.prefecture_id"
          >
            <option
              v-for="profile in profiles"
              :key="profile.value"
              v-bind:value="profile.value"
              >{{ profile.text }}</option
            >
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
          <template v-slot:activator="{ on, attrs }">
            <!-- TODO: 入力値のフォーマットを設定 -->
            <ValidationProvider
              v-slot="{ errors }"
              name="生年月日"
              rules="input_required"
            >
              <v-text-field
                v-model="profile.birthday"
                name="profile[birthday]"
                id="profile_birthday"
                label="生年月日"
                readonly
                v-bind="attrs"
                v-on="on"
              ></v-text-field>
              <span class="text-red-400">{{ errors[0] }}</span>
            </ValidationProvider>
          </template>
          <v-date-picker
            ref="picker"
            color="blue-grey darken-3"
            header-color="blue-grey darken-2"
            locale="ja-jp"
            :day-format="(date) => new Date(date).getDate()"
            v-model="profile.birthday"
            :max="new Date().toISOString().substr(0, 10)"
            min="1950-01-01"
            @change="saveBirthDate"
          ></v-date-picker>
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
          <template v-slot:activator="{ on, attrs }">
            <!-- TODO: 入力値のフォーマットを設定 -->
            <ValidationProvider
              v-slot="{ errors }"
              name="入社日"
              rules="input_required"
            >
              <v-text-field
                name="profile[day_of_joinning]"
                id="profile_day_of_joinning"
                v-model="profile.day_of_joinning"
                label="入社日"
                readonly
                v-bind="attrs"
                v-on="on"
              ></v-text-field>
              <span class="text-red-400">{{ errors[0] }}</span>
            </ValidationProvider>
          </template>
          <v-date-picker
            ref="picker"
            color="blue-grey darken-3"
            header-color="blue-grey darken-2"
            locale="ja-jp"
            :day-format="(date) => new Date(date).getDate()"
            v-model="profile.day_of_joinning"
            @change="saveJoinedDate"
          ></v-date-picker>
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
          >入力完了！</v-btn
        >
      </div>
    </form>
  </ValidationObserver>
</template>

<script>
import { mapActions } from "vuex";

export default {
  name: "ProfileFormPane",
  data() {
    return {
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
      profiles: [
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
  methods: {
    hundleSubmitBasicProfileInfo() {
      console.log("hundleSubmitBasicProfileInfo");
      this.$emit("hundle-submit-basic-profile-info", this.profile);
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

<style scoped>
/* TODO: 色が適用されていない */
.v-date-picker-table.v-date-picker-table--date
  > table
  > tbody
  tr
  td:nth-child(7)
  .v-btn__content {
  color: blue;
}
.v-date-picker-table.v-date-picker-table--date
  > table
  > tbody
  tr
  td:nth-child(1)
  .v-btn__content {
  color: red;
}
</style>
