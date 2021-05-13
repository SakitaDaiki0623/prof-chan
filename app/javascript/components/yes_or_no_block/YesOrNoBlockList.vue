<template>
  <v-container class="rounded-2xl bg-color">
    <v-row
      v-show="isThisEditPage"
      justify="center"
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
    </v-row>
    <div class="block-title">
      Yes or No コーナー
    </div>
    <div>
      <v-row v-if="isMyYesOrNoBlocksLengthNotZero">
        <v-col
          v-for="yesOrNoBlock in myYesOrNoBlocks"
          :key="yesOrNoBlock.id"
          cols="12"
          sm="4"
        >
          <v-card
            class="rounded-2xl p-5 note-box"
            outlined
            color="orange lighten-4"
          >
            <v-row
              v-show="isThisEditPage"
              justify="end"
            >
              <v-btn
                :id="'edit-yes-or-no-block-button-' + yesOrNoBlock.id"
                tile
                small
                color="orange lighten-4"
                @click="openEditYesOrNoFormatDialog(yesOrNoBlock)"
              >
                <v-icon> mdi-pencil </v-icon>
              </v-btn>
              <v-btn
                :id="'delete-yes-or-no-block-button-' + yesOrNoBlock.id"
                tile
                small
                color="orange lighten-1"
                @click="hundleDeleteYesOrNoBlock(yesOrNoBlock)"
              >
                <v-icon> mdi-delete </v-icon>
              </v-btn>
            </v-row>
            <p class="text-2xl font-bold text-gray-600 px-3 pt-3">
              {{ yesOrNoBlock.title }}
            </p>
            <template v-for="yes_or_no_item in yesOrNoBlock.yes_or_no_items">
              <div :key="yes_or_no_item.id">
                <v-card
                  class="p-2 m-2"
                  outlined
                  color="white"
                >
                  <v-row align="center">
                    <v-col
                      cols="12"
                      sm="7"
                    >
                      {{ yes_or_no_item.content }}
                    </v-col>
                    <v-col
                      v-if="yes_or_no_item.answer"
                      cols="12"
                      sm="5"
                    >
                      <span
                        class="rounded-full border-red-500 border-2 p-2"
                      >YES</span>
                      / NO
                    </v-col>
                    <v-col
                      v-else
                      cols="12"
                      sm="5"
                    >
                      YES /
                      <span
                        class="rounded-full border-red-500 border-2 p-2"
                      >NO</span>
                    </v-col>
                  </v-row>
                </v-card>
              </div>
            </template>
          </v-card>
        </v-col>
      </v-row>
      <v-container
        v-else
        class="no-block-display-container"
      >
        <v-row justify="center">
          <div class="font-bold text-2xl opacity-50">
            社員のYes or No ブロックがありません
          </div>
        </v-row>
      </v-container>
    </div>

    <div class="block-title" />
    <YesOrNoFormatDialog
      :is-shown-yes-or-no-format-dialog="isShownYesOrNoFormatDialog"
      :yes-or-no-block-color="yesOrNoBlockColor"
      @close-yes-or-no-format-dialog="closeYesOrNoFormatDialog"
    />
    <EditYesOrNoFormatDialog
      :is-shown-edit-yes-or-no-format-dialog="isShownEditYesOrNoFormatDialog"
      :edit-yes-or-no-block="editYesOrNoBlock"
      :yes-or-no-block-color="yesOrNoBlockColor"
      @close-yes-or-no-block-format-dialog="closeEditYesOrNoFormatDialog"
      @close-yes-or-no-block-edit-dialog="closeYesOrNoBlockEditDialog"
    />
  </v-container>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions } from "vuex";

import YesOrNoFormatDialog from "./YesOrNoFormatDialog";
import EditYesOrNoFormatDialog from "./EditYesOrNoFormatDialog";

export default {
  components: {
    YesOrNoFormatDialog,
    EditYesOrNoFormatDialog,
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
      isShownEditYesOrNoFormatDialog: false,
      editYesOrNoBlock: {},
      yesOrNoBlockColor: "orange lighten-3", // ranking block color
    };
  },
  computed: {
    ...mapState("yesOrNoBlocks", ["yesOrNoBlocks"]),
    ...mapState("users", ["currentUser"]),

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
    ...mapActions({
      fetchYesOrNoBlocks: "yesOrNoBlocks/fetchYesOrNoBlocks",
      deleteYesOrNoBlock: "yesOrNoBlocks/deleteYesOrNoBlock",
      fetchYesOrNoItems: "yesOrNoBlocks/fetchYesOrNoItems",
    }),
    openYesOrNoFormatDialog() {
      this.isShownYesOrNoFormatDialog = true;
    },
    closeYesOrNoFormatDialog() {
      this.isShownYesOrNoFormatDialog = false;
    },
    openEditYesOrNoFormatDialog(yesOrNoBlock) {
      this.editYesOrNoBlock = Object.assign({}, yesOrNoBlock);
      this.isShownEditYesOrNoFormatDialog = true;
    },
    closeEditYesOrNoFormatDialog() {
      this.isShownEditYesOrNoFormatDialog = false;
    },
    closeYesOrNoBlockEditDialog(editYesOrNoBlock) {
      this.editYesOrNoBlock = editYesOrNoBlock;
    },
    hundleDeleteYesOrNoBlock(yesOrNoBlock) {
      if (!confirm("削除してよろしいですか?")) return;
      this.deleteYesOrNoBlock(yesOrNoBlock);
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "Yes or No ブロックを削除したよ！",
        color: this.yesOrNoBlockColor,
      });
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

.note-box {
  position: relative;
}
.note-box::before {
  content: "";
  position: absolute;
  border-right: dashed 5px rgb(155, 155, 155); /*ドットの大きさ、高さ*/
  height: 90%;
  top: 0.5em;
  left: 0.5em;
}

.note-box::after {
  content: "";
  position: absolute;
  border-right: dashed 5px rgb(155, 155, 155); /*ドットの大きさ、高さ*/
  height: 50%;
  top: 3em;
  right: 0.5em;
}

.no-block-display-container {
  height: 300px;
}
</style>
