<template>
  <div>
    <v-card class="rounded-2xl pa-5 note-box" outlined color="orange lighten-4">
      <v-row v-if="isThisEditPage" justify="end">
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
      <v-row v-else>
        <v-spacer />
        <yes-or-no-block-like-button
          :yes-or-no-block-id="yesOrNoBlock.id"
          v-if="isThisNotTopPage"
        />
      </v-row>
      <p class="profile-block-title">
        {{ yesOrNoBlock.title }}
      </p>
      <template v-for="yes_or_no_item in yesOrNoBlock.yes_or_no_items">
        <div :key="yes_or_no_item.id">
          <v-card class="pa-2 ma-2" outlined color="white">
            <v-row align="center">
              <v-col cols="12" sm="7">
                {{ yes_or_no_item.content }}
              </v-col>
              <v-col v-if="yes_or_no_item.answer" cols="12" sm="5">
                <span class="rounded-full border-brown-500 border-2 pa-2"
                  >YES</span
                >
                / NO
              </v-col>
              <v-col v-else cols="12" sm="5">
                YES /
                <span class="rounded-full border-brown-500 border-2 pa-2"
                  >NO</span
                >
              </v-col>
            </v-row>
          </v-card>
        </div>
      </template>
    </v-card>
    <EditYesOrNoFormatDialog
      :is-shown-edit-yes-or-no-format-dialog="isShownEditYesOrNoFormatDialog"
      :edit-yes-or-no-block="editYesOrNoBlock"
      :yes-or-no-block-color="yesOrNoBlockColor"
      @close-yes-or-no-block-format-dialog="closeEditYesOrNoFormatDialog"
      @close-yes-or-no-block-edit-dialog="closeYesOrNoBlockEditDialog"
    />
  </div>
</template>

<script>
import EditYesOrNoFormatDialog from "./EditYesOrNoFormatDialog";
import YesOrNoBlockLikeButton from "../likes/YesOrNoBlockLikeButton";

import { mapActions } from "vuex";

export default {
  components: {
    EditYesOrNoFormatDialog,
    YesOrNoBlockLikeButton,
  },
  props: {
    yesOrNoBlock: {
      type: Object,
      requred: true,
    },
    isThisEditPage: {
      type: Boolean,
      required: false,
      default: false,
    },
    yesOrNoBlockColor: {
      type: String,
      requred: false,
      default: "orange lighten-3",
    },
  },
  data() {
    return {
      isShownEditYesOrNoFormatDialog: false,
      editYesOrNoBlock: {},
    };
  },
  computed: {
    isThisNotTopPage() {
      return this.$route.path == `/top` ? false : true;
    },
  },
  methods: {
    ...mapActions({
      deleteYesOrNoBlock: "yesOrNoBlocks/deleteYesOrNoBlock",
    }),
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
</style>
