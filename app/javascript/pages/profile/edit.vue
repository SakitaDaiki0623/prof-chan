<!-- app/javascript/pages/profile/show.vue -->
<template>
  <div
    class="bg-backimage-02 bg-cover bg-fixed text-gray-600 font-prof-default"
  >
    <v-container>
      <p class="text-5xl font-bold note mb-10">プロフィール編集</p>
      <v-row class="mb-10">
        <v-col cols="12" sm="6">
          <BasicProfCard :currentUser="currentUser" :profile="profile" />
        </v-col>
      </v-row>
      <v-row justify="center">
        <v-btn tile color="success" @click="openProfileBlockSelectDialog">
          <v-icon left> mdi-plus </v-icon>
          ブロックを追加する
        </v-btn>
      </v-row>
    </v-container>
    <TextProfCardList :myTextBlocks="myTextBlocks" />
    <ProfileBlockSelectDialog
      :is-shown-profile-block-select-dialog="isShownProfileBlockSelectDialog"
      @open-text-format-dialog="openTextFormatDialog"
    />
    <TextFormatDialog
      :is-shown-text-format-dialog="isShownTextFormatDialog"
      @close-text-format-dialog="closeTextFormatDialog"
    />
  </div>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions } from "vuex";

// components ----------
import BasicProfCard from "../../components/BasicProfCard";
import ProfileBlockSelectDialog from "../../components/ProfileBlockSelectDialog";
import TextFormatDialog from "../../components/TextFormatDialog";
import TextProfCardList from "../../components/TextProfCardList";

export default {
  components: {
    BasicProfCard,
    ProfileBlockSelectDialog,
    TextFormatDialog,
    TextProfCardList,
  },
  props: {
    id: {
      type: String,
      require: true,
      default: "",
    },
  },
  data() {
    return {
      isShownProfileBlockSelectDialog: false,
      isShownTextFormatDialog: false,
    };
  },
  computed: {
    ...mapState("profiles", ["profiles"]),
    ...mapState("textBlocks", ["textBlocks"]),
    ...mapState("users", ["currentUser"]),

    profile() {
      return this.profiles.find((profile) => profile.id == this.id) || {};
    },
    myTextBlocks() {
      return (
        this.textBlocks.filter(
          (textBlock) => textBlock.profile_block.id == this.currentUser.id
        ) || {}
      );
    },
  },
  mounted() {
    this.fetchProfiles();
    this.fetchTextBlocks();
    this.fetchCurrentUser();

    document.title = `プロフィール編集 - プロフちゃん`;
  },
  methods: {
    ...mapActions("profiles", ["fetchProfiles"]),
    ...mapActions("textBlocks", ["fetchTextBlocks"]),
    ...mapActions("users", ["fetchCurrentUser"]),

    openProfileBlockSelectDialog() {
      this.isShownProfileBlockSelectDialog = true;
    },
    closeProfileBlockSelectDialog() {
      this.isShownProfileBlockSelectDialog = false;
    },
    openTextFormatDialog() {
      this.closeProfileBlockSelectDialog();
      this.isShownTextFormatDialog = true;
    },
    closeTextFormatDialog() {
      this.isShownTextFormatDialog = false;
    },
  },
};
</script>

<style scoped>
.note {
  width: 80%;
  padding: 0 1em;
  background: linear-gradient(#ccc 0.1px, transparent 0.6px) #fffbf2;
  background-size: auto 2.5em;
  line-height: 2.5em;
  border-bottom: 1px solid #ccc;
  border-left: 1px solid #ccc;
  border-right: 1px solid #ccc;
  overflow: hidden;
}
</style>
