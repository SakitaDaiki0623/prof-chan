<template>
  <v-container
    class="rounded-2xl bg-brown-300"
    v-show="isMyYesOrNoBlocksLengthNotZero || isThisEditPage"
  >
    <div class="text-center text-5xl text-white py-5 my-5 top-sub-title">
      <span class="text-yellow-300 rounded-full px-2 bg-white">Y</span> Yes or
      No コーナー
    </div>
    <v-row v-show="isThisEditPage" justify="center" class="py-5">
      <v-col cols="12" sm="12" align="center">
        <v-btn
          id="add-yes-or-no-block-btn"
          tile
          :color="yesOrNoBlockColor"
          class="ma-2 white--text"
          @click="openYesOrNoFormatDialog"
        >
          <v-icon left>
            mdi-plus
          </v-icon>
          Yes or No ブロックを追加する
        </v-btn>
      </v-col>
      <v-col cols="12" sm="8" align="right">
        <ProgressBar
          :percentage-for-blocks="percentageMyYesOrNoBlocksLengt"
          :block-color="yesOrNoBlockColor"
        />
      </v-col>
    </v-row>
    <div>
      <transition-group
        tag="v-row"
        name="list"
        v-if="isMyYesOrNoBlocksLengthNotZero"
      >
        <v-col
          v-for="yesOrNoBlock in myYesOrNoBlocks"
          :key="yesOrNoBlock.id"
          cols="12"
          sm="4"
          class="border-b-2 border-yellow-300 border-dashed"
        >
          <YesOrNoBlockCard
            :yes-or-no-block="yesOrNoBlock"
            :is-this-edit-page="isThisEditPage"
            :yes-or-no-block-color="yesOrNoBlockColor"
          />
        </v-col>
      </transition-group>
      <v-container v-else class="no-block-display-container">
        <v-row justify="center">
          <div class="font-bold text-2xl opacity-50">
            社員のYes or No ブロックがありません
          </div>
        </v-row>
      </v-container>
    </div>

    <YesOrNoFormatDialog
      :is-shown-yes-or-no-format-dialog="isShownYesOrNoFormatDialog"
      :yes-or-no-block-color="yesOrNoBlockColor"
      @close-yes-or-no-format-dialog="closeYesOrNoFormatDialog"
    />
  </v-container>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions } from "vuex";

import YesOrNoFormatDialog from "./YesOrNoFormatDialog";
import YesOrNoBlockCard from "./YesOrNoBlockCard";
import ProgressBar from "../ProgressBar";

export default {
  components: {
    YesOrNoFormatDialog,
    YesOrNoBlockCard,
    ProgressBar,
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
  data() {
    return {
      // YesOrNo Block
      isShownYesOrNoFormatDialog: false,
      yesOrNoBlockColor: "orange lighten-3", // ranking block color
    };
  },
  computed: {
    ...mapState("yesOrNoBlocks", ["yesOrNoBlocks"]),
    ...mapState("users", ["currentUser"]),

    percentageMyYesOrNoBlocksLengt() {
      if (this.myYesOrNoBlocks.length / 5 >= 1) return 100;
      return (this.myYesOrNoBlocks.length / 5) * 100;
    },

    myYesOrNoBlocks() {
      return (
        this.yesOrNoBlocks.filter(
          (yesOrNoBlock) =>
            yesOrNoBlock.profile_block.id == this.user.profile_block.id
        ) || {}
      );
    },

    isMyYesOrNoBlocksLengthNotZero() {
      return this.myYesOrNoBlocks.length !== 0 ? true : false;
    },
  },
  methods: {
    openYesOrNoFormatDialog() {
      this.isShownYesOrNoFormatDialog = true;
    },
    closeYesOrNoFormatDialog() {
      this.isShownYesOrNoFormatDialog = false;
    },
  },
};
</script>

<style scoped>
/* .bg-color {
  background-color: #ffebca;
} */

.block-title {
  color: #ffb74b; /* 文字色 */
  padding: 5px 5px 5px 30px; /* 上・右・下・左の余白 */
  position: relative;
  font-size: 2rem;
  margin: 0.5rem;
}

.block-title::before {
  background-color: #ffb74b;
  border-radius: 5px;
  content: "";
  position: absolute;
  top: 0;
  left: 3px; /* 左端からの位置 */
  width: 5px; /* 左側の線の幅 */
  height: 100%;
}

.block-title::after {
  background-color: #f3a3a8; /* 1個目（一番左）のドットの色 */
  border-radius: 50%;
  content: "";
  margin-left: 15px; /* 最後の文字とドットとの余白 */
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 5px; /* ドットの幅 */
  height: 5px; /* ドットの高さ */
  box-shadow: 20px 0px 0px rgb(217, 204, 179), 40px 0px 0px rgb(217, 204, 179),
    60px 0px 0px rgb(243, 163, 168), 80px 0px 0px rgb(217, 204, 179),
    100px 0px 0px rgb(217, 204, 179), 120px 0px 0px rgb(243, 163, 168),
    140px 0px 0px rgb(217, 204, 179), 160px 0px 0px rgb(217, 204, 179),
    180px 0px 0px rgb(243, 163, 168), 200px 0px 0px rgb(217, 204, 179),
    220px 0px 0px rgb(217, 204, 179);
}

.no-block-display-container {
  height: 300px;
}
</style>
