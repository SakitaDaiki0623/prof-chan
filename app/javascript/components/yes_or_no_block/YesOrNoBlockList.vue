<template>
  <v-card
    v-show="isMyYesOrNoBlocksLengthNotZero || isThisEditPage"
    color="brown lighten-4"
    outlined
    class="mb-10 pa-5"
  >
    <div class="corner-title top-sub-title">
      <span
        class="yellow--text text--darken-3 rounded-full px-2 bg-white"
      >Y</span>
      Yes or No コーナー
    </div>
    <v-row
      v-show="isThisEditPage"
      justify="center"
      class="py-5"
    >
      <v-col
        cols="12"
        sm="12"
        align="center"
      >
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
      <v-col
        cols="12"
        sm="8"
        align="right"
      >
        <ProgressBar
          :percentage-for-blocks="percentageMyYesOrNoBlocksLengt"
          :block-color="yesOrNoBlockColor"
        />
      </v-col>
    </v-row>
    <div class="text-center">
      <v-pagination
        v-show="isPageSizeBiggerThanMyYesOrNoBlocks && !isThisEditPage"
        v-model="page"
        :length="length"
        circle
        :color="yesOrNoBlockColor"
        class="mb-10"
        @input="pageChange"
      />
    </div>
    <div>
      <transition-group
        v-if="isMyYesOrNoBlocksLengthNotZero && !isThisEditPage"
        tag="v-row"
        name="list"
      >
        <v-col
          v-for="yesOrNoBlock in displayBlocks"
          :key="yesOrNoBlock.id"
          cols="12"
          md="6"
          lg="4"
          class="border-b-2 border-brown-300 border-dashed"
        >
          <YesOrNoBlockCard
            :yes-or-no-block="yesOrNoBlock"
            :is-this-edit-page="isThisEditPage"
            :yes-or-no-block-color="yesOrNoBlockColor"
          />
        </v-col>
      </transition-group>
      <transition-group
        v-else-if="isMyYesOrNoBlocksLengthNotZero && isThisEditPage"
        tag="v-row"
        name="list"
      >
        <v-col
          v-for="yesOrNoBlock in myYesOrNoBlocks"
          :key="yesOrNoBlock.id"
          cols="12"
          md="6"
          lg="4"
          class="border-b-2 border-brown-300 border-dashed"
        >
          <YesOrNoBlockCard
            :yes-or-no-block="yesOrNoBlock"
            :is-this-edit-page="isThisEditPage"
            :yes-or-no-block-color="yesOrNoBlockColor"
          />
        </v-col>
      </transition-group>
      <NoBlockContainer
        v-else
        block-name="Yes or No "
      />
    </div>

    <YesOrNoFormatDialog
      :is-shown-yes-or-no-format-dialog="isShownYesOrNoFormatDialog"
      :yes-or-no-block-color="yesOrNoBlockColor"
      @close-yes-or-no-format-dialog="closeYesOrNoFormatDialog"
    />
  </v-card>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions } from "vuex";

import YesOrNoFormatDialog from "./YesOrNoFormatDialog";
import YesOrNoBlockCard from "./YesOrNoBlockCard";
import ProgressBar from "../ProgressBar";
import NoBlockContainer from "../static/NoBlockContainer";

export default {
  components: {
    YesOrNoFormatDialog,
    YesOrNoBlockCard,
    ProgressBar,
    NoBlockContainer,
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
      yesOrNoBlockColor: "orange lighten-3", // block color

      // pagination
      page: 1,
      displayBlocks: [],
      pageSize: 3,
      length: 0,
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

    isPageSizeBiggerThanMyYesOrNoBlocks() {
      return this.myYesOrNoBlocks.length > this.pageSize ? true : false;
    },

    isMyYesOrNoBlocksLengthNotZero() {
      return this.myYesOrNoBlocks.length !== 0 ? true : false;
    },
  },
  mounted() {
    this.pageFirstRead();
  },
  methods: {
    ...mapActions({
      fetchYesOrNoBlocks: "yesOrNoBlocks/fetchYesOrNoBlocks",
      fetchYesOrNoItems: "yesOrNoBlocks/fetchYesOrNoItems",
    }),
    openYesOrNoFormatDialog() {
      this.isShownYesOrNoFormatDialog = true;
    },
    closeYesOrNoFormatDialog() {
      this.isShownYesOrNoFormatDialog = false;
    },
    pageChange(pageNumber) {
      this.displayBlocks = this.myYesOrNoBlocks.slice(
        this.pageSize * (pageNumber - 1),
        this.pageSize * pageNumber
      );
    },
    async pageFirstRead() {
      await this.fetchYesOrNoBlocks();
      await this.fetchYesOrNoItems();
      this.length = Math.ceil(this.myYesOrNoBlocks.length / this.pageSize);
      this.displayBlocks = this.myYesOrNoBlocks.slice(0, this.pageSize);
    },
  },
};
</script>

<style scoped></style>
