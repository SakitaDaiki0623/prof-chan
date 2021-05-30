<template>
  <v-footer app absolute color="brown lighten-3">
    <div>
      <small class="text-white"> &copy; {{ copyText }}</small>
      <v-btn dense text class="white--text" @click="openTermsDialog">
        利用規約
      </v-btn>
      <v-btn dense text class="white--text" @click="openPrivacyDialog">
        プライバシー・ポリシー
      </v-btn>
    </div>
    <TheTerms
      :is-shown-terms="isShownTerms"
      @close-terms-dialog="closeTermsDialog"
    />
    <ThePrivacy
      :is-shown-privacy="isShownPrivacy"
      @close-privacy-dialog="closePrivacyDialog"
    />
  </v-footer>
</template>

<script>
import TheTerms from "../static/TheTerms";
import ThePrivacy from "../static/ThePrivacy";

export default {
  components: {
    TheTerms,
    ThePrivacy,
  },
  data() {
    return {
      startYear: 2021,
      isShownTerms: false,
      isShownPrivacy: false,
    };
  },
  computed: {
    thisYear() {
      return new Date().getFullYear();
    },
    copyText() {
      if (this.startYear === this.thisYear) {
        return `${this.thisYear} - プロフちゃん`;
      }
      return `${this.startYear} - ${this.thisYear} - プロフちゃん`;
    },
  },
  methods: {
    openTermsDialog() {
      this.isShownTerms = true;
    },
    openPrivacyDialog() {
      this.isShownPrivacy = true;
    },
    closeTermsDialog() {
      this.isShownTerms = false;
    },
    closePrivacyDialog() {
      this.isShownPrivacy = false;
    },
  },
};
</script>

<style lang="scss" scoped>
small {
  margin-left: 20px;
}
.v-btn:not(.v-btn--round).v-size--default {
  padding: 0 5px;
}
</style>
