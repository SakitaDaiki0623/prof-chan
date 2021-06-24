<template>
  <v-container>
    <v-row>
      <template v-if="isThisEditPage">
        <v-col
          cols="12"
          sm="12"
          lg="4"
        >
          <div
            class="text-4xl text-center pa-5 bg-white rounded-full text-center border-2 border-dashed border-brown-500"
          >
            プロフ編集
          </div>
          <img
            src="../../images/prof_normal.png"
            class="md:max-w-sm max-w-xs mx-auto"
          >
        </v-col>
      </template>
      <template v-else>
        <v-col
          cols="12"
          sm="12"
          lg="4"
        >
          <div
            class="text-4xl text-center pa-5 bg-white rounded-full text-center border-2 border-dashed border-brown-500"
          >
            プロフ閲覧
          </div>
          <img
            src="../../images/prof_open_normal.png"
            class="md:max-w-sm max-w-xs mx-auto"
          >
        </v-col>
      </template>
      <v-col
        cols="12"
        sm="12"
        lg="4"
      >
        <ProfCard
          :user="user"
          :is-this-edit-page="isThisEditPage"
        />
      </v-col>
      <v-col
        cols="12"
        sm="12"
        lg="4"
      >
        <BasicProfCard
          :is-this-edit-page="isThisEditPage"
          :user="user"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
// components ----------
import BasicProfCard from "./BasicProfCard";
import ProfCard from "./ProfCard";

export default {
  components: {
    BasicProfCard,
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
      default: {},
    },
  },
};
</script>
