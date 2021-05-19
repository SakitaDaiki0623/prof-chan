<template>
  <div
    :id="'profile-index-card-' + profile.id"
    class="bg-prof-card bg-cover shadow rounded-2xl duration-300 hover:shadow-xl transform hover:scale-105"
    @click="openProfileShowPage(profile)"
  >
    <div class="flex">
      <div class="md:w-2/5 ml-4">
        <div class="w-full mt-10">
          <img
            class="ring-4 ring-gray-600"
            :src="profile.user.image.url"
          >
        </div>
        <div>
          <label
            for="name"
            class="pt-2 text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
          >名前</label>
          <br>
          <div class="text-lg font-bold inline-block">
            <p>{{ profile.user.name }}</p>
          </div>
        </div>
      </div>
      <div class="p-8 text-sm">
        <div class="p-1">
          <label
            for="birthday"
            class="text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
          >性別</label>
          {{ profile.gender }}
        </div>

        <div class="p-1">
          <label
            for="birthday"
            class="text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
          >身長</label>{{ profile.height }} cm
        </div>

        <div class="p-1">
          <label
            for="birthday"
            class="text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
          >血液型</label>{{ profile.blood_type }} 型
        </div>

        <div class="p-1">
          <label
            for="birthday"
            class="text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
          >出身地</label>{{ profile.prefecture_id }}
        </div>
        <div class="p-1">
          <label
            for="birthday"
            class="text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
          >誕生日</label>
          {{ profile.birthday | moment }}
        </div>
        <div class="p-1">
          <label
            for="birthday"
            class="text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
          >入社日</label>

          {{ profile.day_of_joinning | moment }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import moment from "moment";

export default {
  filters: {
    moment: function(date) {
      return moment(date).format("YYYY/MM/DD");
    },
  },
  props: {
    profile: {
      type: Object,
      required: true,
    },
  },
  computed: {
    translateGender() {
      return this.profile.gender == "male" ? "男性" : "女性";
    },
  },
  methods: {
    openProfileShowPage(profile) {
      this.$router.push(`/profiles/${profile.id}`);
    },
  },
};
</script>
