<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="12" sm="6">
        <v-card class="shadow rounded-2xl bg-question-prof-block bg-cover">
          <div class="flex p-3">
            <div class="md:w-2/4 text-center">
              <div
                class="border-b-2 border-gray-600 border-4 border-gray-300 m-5"
              >
                ★基本情報★
              </div>
              <div class="flex justify-center">
                <img
                  class="ring-4 ring-gray-600 w-9/12"
                  :src="profile.user.image"
                />
              </div>
              <div>
                <div class="text-xl font-bold inline-block mt-4">
                  <label
                    for="name"
                    class="pt-2 text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
                    >名前</label
                  >
                  {{ profile.user.name }}
                </div>
              </div>
            </div>
            <div class="p-2 text-lg md:w-2/4">
              <v-row justify="end">
                <v-btn
                  tile
                  small
                  color="red lighten-4"
                  @click="openEditBasicProfCard"
                >
                  <v-icon> mdi-pencil </v-icon>
                </v-btn>
              </v-row>
              <div class="p-2">
                <label
                  for="birthday"
                  class="text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
                  >性別</label
                >
                {{ profile.gender }}
              </div>

              <div class="p-2">
                <label
                  for="birthday"
                  class="text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
                  >身長</label
                >{{ profile.height }} cm
              </div>

              <div class="p-2">
                <label
                  for="birthday"
                  class="text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
                  >血液型</label
                >{{ profile.blood_type }} 型
              </div>

              <div class="p-2">
                <label
                  for="birthday"
                  class="text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
                  >出身地</label
                >{{ profile.prefecture_id }}
              </div>
              <div class="p-2">
                <label
                  for="birthday"
                  class="text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
                  >誕生日</label
                >
                {{ profile.birthday | moment }}
              </div>
              <div class="p-2">
                <label
                  for="birthday"
                  class="text-xs font-medium bg-green-100 py-1 px-2 rounded text-green-500"
                  >入社日</label
                >

                {{ profile.day_of_joinning | moment }}
              </div>
            </div>
          </div>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import moment from "moment";
import { mapState } from "vuex";

export default {
  filters: {
    moment: function (date) {
      return moment(date).format("YYYY/MM/DD");
    },
  },
  props: {
    profile: {
      type: Object,
      required: true,
    },
  },
  computed: {},
  methods: {
    openEditBasicProfCard() {
      this.$emit("open-edit-basic-prof-card", this.profile);
    },
  },
};
</script>
