<!-- app/javascript/components/address_block/EditAddressBlockDialog.vue -->
<template>
  <v-dialog
    :value="isShownEditAddressBlockDialog"
    persistent
    max-width="800"
    @input="$emit('input', $event.target.isShownEditAddressBlockDialog)"
  >
    <v-card class="pa-5">
      <v-row justify="end">
        <v-btn
          @click="hundleCloseEditAddressBlockDialog"
        >
          <v-icon> mdi-close-outline </v-icon>
        </v-btn>
      </v-row>
      <ValidationObserver
        ref="observer"
        v-slot="{ invalid }"
      >
        <form @submit.prevent="hundleUpdateAddressBlock">
          <section>
            <p>
              <label class="form-label-basic-block">Twitter</label>
              <v-icon>mdi-twitter</v-icon>
              <input
                v-model="editMyAddressBlock.twitter"
                type="text"
                class="address-form"
              >
            </p>
            <p>
              <label class="form-label-basic-block">Instagram</label>
              <v-icon>mdi-instagram</v-icon>
              <input
                v-model="editMyAddressBlock.instagram"
                type="text"
                class="address-form"
              >
            </p>
            <div>
              <ValidationObserver
                ref="observer"
                v-slot="{ invalid }"
              >
                <label class="form-label-basic-block">郵便番号</label>
                <!-- TODO: ポストコードの正規表現がうまくいかないので後ほど追記 -->
                <ValidationProvider
                  rules="input_required|regex: /^[0-9]{7}$/"
                  name="郵便番号"
                >
                  〒<input
                    v-model="editMyAddressBlock.postcode"
                    type="text"
                    class="address-form"
                    placeholder="郵便番号を入力"
                  >
                </ValidationProvider>
                <v-btn
                  :disabled="invalid"
                  @click="searchAddressInfo"
                >
                  住所を自動で入力!
                </v-btn>
              </ValidationObserver>
            </div>
            <br>
            <label class="form-label-basic-block">住所</label>
            <input
              v-model="editMyAddressBlock.full_address"
              type="text"
              class="address-form"
              placeholder="東京都西東京市谷戸町1-157-12"
            >
          </section>
          <div class="text-center mt-3">
            <v-btn
              id="update-my-favorite-block-button"
              type="submit"
              depressed
              elevation="4"
              x-large
              :disabled="invalid"
              color="teal lighten-3"
              class="white--text"
            >
              アドレスブロックを更新！
            </v-btn>
          </div>
        </form>
      </ValidationObserver>
    </v-card>
  </v-dialog>
</template>

<script>
import axios from "axios";

const url = "https://api.zipaddress.net/?zipcode=";

export default {
  props: {
    isShownEditAddressBlockDialog: {
      type: Boolean,
      required: true,
    },
    editMyAddressBlock: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      zipcode: "",
    };
  },
  methods: {
    searchAddressInfo() {
      axios.get(url + this.editMyAddressBlock.postcode).then((res) => {
        this.$emit("update-address-automatically", res.data.data.fullAddress);
      });
    },
    patchAddressBlock: async function () {
      const res = await axios.patch(
        `/api/v1/address_blocks/${this.editMyAddressBlock.id}`,
        this.editMyAddressBlock
      );
      if (res.status !== 200) {
        process.exit();
      }
      return res.data;
    },
    hundleUpdateAddressBlock() {
      this.patchAddressBlock().then((result) => {
        this.$emit("update-address-block", result);
      });
      this.hundleCloseEditAddressBlockDialog();
    },
    hundleCloseEditAddressBlockDialog() {
      this.$emit("close-edit-address-block-dialog");
    },
  },
};
</script>
