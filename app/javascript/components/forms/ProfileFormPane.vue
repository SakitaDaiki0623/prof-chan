<template>
  <ValidationObserver ref="observer" v-slot="{ invalid }">
    <form @submit.prevent="hundleSubmitBasicProfileInfo">
      <div>
        <label class="form-label" for="profile_height">身長</label>
        <ValidationProvider v-slot="{ errors }" name="身長" rules="required">
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
          rules="oneOf:A,B,AB,O"
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
        <label class="form-label" for="profile_prefecture_id">出身地</label
        ><select
          class="input-form"
          name="profile[prefecture_id]"
          id="profile_prefecture_id"
          v-model="profile.prefecture_id"
        >
          <option value="1">北海道</option>
          <option value="2">青森県</option>
          <option value="3">岩手県</option>
          <option value="4">宮城県</option>
          <option value="5">秋田県</option>
          <option value="6">山形県</option>
          <option value="7">福島県</option>
          <option value="8">茨城県</option>
          <option value="9">栃木県</option>
          <option value="10">群馬県</option>
          <option value="11">埼玉県</option>
          <option value="12">千葉県</option>
          <option value="13">東京都</option>
          <option value="14">神奈川県</option>
          <option value="15">新潟県</option>
          <option value="16">富山県</option>
          <option value="17">石川県</option>
          <option value="18">福井県</option>
          <option value="19">山梨県</option>
          <option value="20">長野県</option>
          <option value="21">岐阜県</option>
          <option value="22">静岡県</option>
          <option value="23">愛知県</option>
          <option value="24">三重県</option>
          <option value="25">滋賀県</option>
          <option value="26">京都府</option>
          <option value="27">大阪府</option>
          <option value="28">兵庫県</option>
          <option value="29">奈良県</option>
          <option value="30">和歌山県</option>
          <option value="31">鳥取県</option>
          <option value="32">島根県</option>
          <option value="33">岡山県</option>
          <option value="34">広島県</option>
          <option value="35">山口県</option>
          <option value="36">徳島県</option>
          <option value="37">香川県</option>
          <option value="38">愛媛県</option>
          <option value="39">高知県</option>
          <option value="40">福岡県</option>
          <option value="41">佐賀県</option>
          <option value="42">長崎県</option>
          <option value="43">熊本県</option>
          <option value="44">大分県</option>
          <option value="45">宮崎県</option>
          <option value="46">鹿児島県</option>
          <option value="47">沖縄県</option>
        </select>
      </div>
      <div>
        <label class="form-label" for="profile_gender">性別</label
        ><select
          class="input-form"
          name="profile[gender]"
          id="profile_gender"
          v-model="profile.gender"
        >
          <option value="male">男性</option>
          <option value="female">女性</option>
        </select>
      </div>
      <div>
        <label class="form-label" for="profile_birthday">生年月日</label
        ><input
          class="input-form"
          type="date"
          name="profile[birthday]"
          id="profile_birthday"
          v-model="profile.birthday"
        />
      </div>
      <div>
        <label class="form-label" for="profile_day_of_joinning">入社日</label
        ><input
          class="input-form"
          type="date"
          name="profile[day_of_joinning]"
          id="profile_day_of_joinning"
          v-model="profile.day_of_joinning"
        />
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
      errors: "",
    };
  },
  methods: {
    hundleSubmitBasicProfileInfo() {
      console.log("hundleSubmitBasicProfileInfo");
      this.$emit("hundle-submit-basic-profile-info", this.profile);
    },
  },
};
</script>
