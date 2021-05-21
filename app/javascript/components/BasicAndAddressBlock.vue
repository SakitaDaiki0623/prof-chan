<template>
  <v-container class="text-gray-600">
    <v-row>
      <v-col cols="12" sm="4">
        <ProfCard :user="user" :is-this-edit-page="isThisEditPage" />
      </v-col>
      <v-col cols="12" sm="4">
        <BasicProfCard :is-this-edit-page="isThisEditPage" :user="user" />
      </v-col>
      <template v-if="isThisEditPage">
        <v-col cols="12" sm="4">
          <div
            class="text-4xl text-center p-5 bg-white rounded-full text-center"
          >
            プロフ編集
          </div>
          <img src="../images/prof_normal.png" class="max-w-sm" />
        </v-col>
      </template>
      <template v-else>
        <v-col cols="12" sm="4">
          <div
            class="text-4xl text-center p-5 bg-white rounded-full text-center"
          >
            プロフ閲覧
          </div>
          <img src="../images/prof_open_normal.png" class="max-w-sm" />
        </v-col>
      </template>
    </v-row>
  </v-container>
</template>

<script>
// components ----------
import BasicProfCard from "./basic_profile/BasicProfCard";
import AddressBlock from "./address_block/AddressBlock";
import ProfCard from "./ProfCard";

export default {
  components: {
    BasicProfCard,
    AddressBlock,
    ProfCard,
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
      default: false,
    },
  },
};
</script>
