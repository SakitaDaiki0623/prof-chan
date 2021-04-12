<template>
  <v-card class="bg-prof-card bg-cover shadow rounded-2xl">
    <div class="flex">
      <div class="md:w-2/5 ml-4">
        <div class="w-full mt-10">
          <img
            class="ring-4 ring-gray-600"
            :src="profile.user.image"
          >
        </div>
        <div>
          <div class="text-lg font-bold inline-block">
            <label
              for="name"
              class="pt-2 text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
            >名前</label>
            <br>
            {{ profile.user.name }}
          </div>
        </div>
      </div>
    </div>
  </v-card>
</template>

<script>
// plugins
import moment from "moment";

//components

export default {
  components: {},
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
  methods: {},
};
</script>
