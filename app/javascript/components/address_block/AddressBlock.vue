<template>
  <v-card
    class="pa-5"
    color="yellow lighten-4"
    outlined
  >
    <v-row
      v-show="isThisEditPage"
      justify="end"
    >
      <v-btn
        id="edit-address-block-button"
        tile
        small
        color="yellow lighten-4"
        @click="openEditAddressBlockDialog"
      >
        <v-icon> mdi-pencil </v-icon>
      </v-btn>
    </v-row>
    <p class="font-weight-bold text-4xl text-gray-600 text-center">
      アドレスコーナー
    </p>
    <v-row>
      <v-col
        cols="12"
        sm="6"
      >
        <v-icon>mdi-twitter</v-icon>Twitter
        <v-card
          outlined
          color="white"
          min-height="30px"
        >
          {{
            myAddressBlock.twitter
          }}
        </v-card>
      </v-col>
      <v-col
        cols="12"
        sm="6"
      >
        <v-icon>mdi-instagram</v-icon>Instagram
        <v-card
          outlined
          color="white"
          min-height="30px"
        >
          {{
            myAddressBlock.instagram
          }}
        </v-card>
      </v-col>
    </v-row>
    <br>
    <v-icon>mdi-home</v-icon><label>住所</label>
    <v-card
      color="white"
      outlined
      class="pa-2"
    >
      <p>〒: {{ myAddressBlock.postcode }}</p>
      <p>
        {{ myAddressBlock.full_address }}
      </p>
    </v-card>
    <EditAddressBlockDialog
      :is-shown-edit-address-block-dialog="isShownEditAddressBlockDialog"
      :edit-my-address-block="editMyAddressBlock"
      @close-edit-address-block-dialog="closeEditAddressBlockDialog"
      @update-address-automatically="updateAddressAutomatically"
      @update-address-block="updateAddressBlock"
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
    user: {
      type: Object,
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
          addressBlock.profile_block.id == this.user.profile_block.id
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
