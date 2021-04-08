<!-- app/javascript/pages/profile/index.vue -->
<template>
  <div class="bg-backimage bg-cover bg-fixed text-gray-600 font-prof-default">
    <TheHeader />
    <v-container class="note shadow-lg mb-20">
      <p class="text-5xl font-bold pt-10 pb-10">社員プロフィール一覧</p>
      <v-row class="mb-10">
        <v-col
          v-for="profile in getProfiles"
          :key="profile.id"
          cols="12"
          sm="4"
        >
          <div class="bg-prof-card bg-cover shadow rounded-2xl">
            <div class="flex">
              <div class="md:w-2/5 ml-4">
                <div class="w-full mt-10">
                  <img class="ring-4 ring-gray-600" :src="profile.user.image" />
                </div>
                <div>
                  <label
                    for="name"
                    class="pt-2 text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
                    >名前</label
                  >
                  <div class="text-lg font-bold inline-block">
                    {{ profile.user.name }}
                  </div>
                </div>
              </div>
              <div class="md:w-3/5 p-8 text-sm">
                <div class="p-1">
                  <label
                    for="birthday"
                    class="text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
                    >性別</label
                  >{{ profile.gender }}
                </div>

                <div class="p-1">
                  <label
                    for="birthday"
                    class="text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
                    >身長</label
                  >{{ profile.height }} cm
                </div>

                <div class="p-1">
                  <label
                    for="birthday"
                    class="text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
                    >血液型</label
                  >{{ profile.blood_type }} 型
                </div>

                <div class="p-1">
                  <label
                    for="birthday"
                    class="text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
                    >出身地</label
                  >{{ profile.prefecture_id }}
                </div>
                <div class="p-1">
                  <label
                    for="birthday"
                    class="text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
                    >誕生日</label
                  >
                  <div>{{ profile.birthday | moment }}</div>
                </div>
                <div class="p-1">
                  <label
                    for="birthday"
                    class="text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
                    >入社日</label
                  >
                  <div>
                    {{ profile.day_of_joinning | moment }}
                  </div>
                </div>
              </div>
            </div>
          </div>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import axios from "axios";
import { mapGetters, mapActions } from "vuex";
import moment from "moment";

// Component ----------
import TheHeader from "../../components/shared/TheHeader";

export default {
  components: {
    TheHeader,
  },
  data() {
    return {
      profiles: [],
    };
  },
  mounted() {
    document.title = "プロフィール一覧 - プロフちゃん";
  },
  created() {
    console.log("fetchProfiles");
    this.fetchProfiles();
  },
  computed: {
    ...mapGetters("profiles", ["getProfiles"]),
  },
  methods: {
    ...mapActions("profiles", ["fetchProfiles"]),
  },
  filters: {
    moment: function (date) {
      return moment(date).format("YYYY年/MM月/DD日");
    },
  },
};
</script>

<style scoped>
.note {
  width: 80%;
  padding: 0 1em;
  background: linear-gradient(#ccc 0.1px, transparent 0.6px) #fffbf2;
  background-size: auto 2.5em;
  line-height: 2.5em;
  border-bottom: 1px solid #ccc;
  border-left: 1px solid #ccc;
  border-right: 1px solid #ccc;
  overflow: hidden;
}
</style>
