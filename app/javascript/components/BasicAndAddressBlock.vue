<template>
  <v-container>
    <v-row>
      <v-col cols="12" sm="6">
        <BasicProfCard :is-this-edit-page="isThisEditPage" :user="user" />
      </v-col>
      <v-col cols="12" sm="6">
        <AddressBlock :is-this-edit-page="isThisEditPage" :user="user" />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
// components ----------
import BasicProfCard from "./basic_profile/BasicProfCard";
import AddressBlock from "./address_block/AddressBlock";

export default {
  components: {
    BasicProfCard,
    AddressBlock,
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
    },
  },
};
</script>
