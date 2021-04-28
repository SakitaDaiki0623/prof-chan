<template>
  <v-card class="pa-5">
    <v-row justify="end" v-show="isThisEditPage">
      <v-btn
        tile
        small
        color="red lighten-4"
        @click="openEditAddressBlockDialog"
      >
        <v-icon> mdi-pencil </v-icon>
      </v-btn>
    </v-row>
    <p class="font-weight-bold text-4xl text-gray-600 text-center">
      アドレスコーナー
    </p>
    <p>
      Twitter:
      <span>{{ myAddressBlock.twitter }}</span>
    </p>
    <p>
      Instagram:
      <span>{{ myAddressBlock.instagram }}</span>
    </p>
    <div>
      <p>住所</p>
      <p>〒{{ myAddressBlock.postcode }}</p>
      <p>
        {{ myAddressBlock.full_address }}
      </p>
    </div>
    <EditAddressBlockDialog
      @close-edit-address-block-dialog="closeEditAddressBlockDialog"
      @update-address-automatically="updateAddressAutomatically"
      @update-address-block="updateAddressBlock"
      :is-shown-edit-address-block-dialog="isShownEditAddressBlockDialog"
      :edit-my-address-block="editMyAddressBlock"
    />
  </v-card>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";

import EditAddressBlockDialog from "./EditAddressBlockDialog";

export default {
  components: {
    EditAddressBlockDialog,
  },
  props: {
    isThisEditPage: {
      type: Boolean,
      required: false,
      default: false,
    },
  },
  data() {
    return {
      isShownEditAddressBlockDialog: false,
      myAddressBlock: {},
      editMyAddressBlock: {},
    };
  },
  computed: {
    ...mapState("users", ["currentUser"]),
  },
  created() {
    this.fetchAddressBlock().then((result) => {
      const res = result.find(
        (addressBlock) =>
          addressBlock.profile_block.id == this.currentUser.profile_block.id
      );
      this.myAddressBlock = res;
    });
  },
  methods: {
    fetchAddressBlock: async function() {
      const res = await axios.get("/api/v1/address_blocks");
      if (res.status !== 200) {
        process.exit();
      }
      return res.data;
    },
    openEditAddressBlockDialog() {
      this.editMyAddressBlock = Object.assign({}, this.myAddressBlock);
      this.isShownEditAddressBlockDialog = true;
    },
    closeEditAddressBlockDialog() {
      this.isShownEditAddressBlockDialog = false;
    },
    updateAddressAutomatically(fullAddress) {
      this.editMyAddressBlock.full_address = fullAddress;
    },
    updateAddressBlock(result) {
      this.myAddressBlock = result;
    },
  },
};
</script>
