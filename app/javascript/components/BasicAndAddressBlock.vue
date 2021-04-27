<template>
  <v-container>
    <v-row>
      <v-col cols="12" sm="6">
        <BasicProfCard />
      </v-col>
      <v-col cols="12" sm="6">
        <AddressBlock />
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
};
</script>
