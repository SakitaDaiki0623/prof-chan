<template>
  <v-footer app absolute color="brown lighten-3">
    <div class="term-font">
      <small class="text-white text-sm leading-10">
        &copy; {{ copyText }}</small
      >
      <v-btn dense text class="white--text" @click="openTermsDialog">
        利用規約
      </v-btn>
      <v-btn dense text class="white--text" @click="openPrivacyDialog">
        プライバシー・ポリシー
      </v-btn>
      <v-btn
        icon
        color="white"
        href="https://twitter.com/profchanjp"
        target="_blank"
      >
        <v-icon> mdi-twitter </v-icon>
      </v-btn>
      <v-btn  dense color="brown" class="text--brown-900">
        <a
          title="Twitter"
          target="_blank"
          rel="noopener noreferrer"
          class="ml-5 p-1 white--text"
          onfocus="this.blur();"
          href="https://twitter.com/share?&amp;url=https://www.prof-chan.com&amp;text=%0D%0Aフルリモート体制の会社員に贈る、社内プロフィール共有サービス 【プロフちゃん】&amp;hashtags=リモートワーク,プロフ帳,コロナ&amp;lang=ja"
          ><svg
            class="svg-inline--fa fa-twitter fa-w-16"
            aria-hidden="true"
            focusable="false"
            data-prefix="fab"
            data-icon="twitter"
            role="img"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 512 512"
            data-fa-i2svg=""
          >
            <path
              fill="currentColor"
              d="M459.37 151.716c.325 4.548.325 9.097.325 13.645 0 138.72-105.583 298.558-298.558 298.558-59.452 0-114.68-17.219-161.137-47.106 8.447.974 16.568 1.299 25.34 1.299 49.055 0 94.213-16.568 130.274-44.832-46.132-.975-84.792-31.188-98.112-72.772 6.498.974 12.995 1.624 19.818 1.624 9.421 0 18.843-1.3 27.614-3.573-48.081-9.747-84.143-51.98-84.143-102.985v-1.299c13.969 7.797 30.214 12.67 47.431 13.319-28.264-18.843-46.781-51.005-46.781-87.391 0-19.492 5.197-37.36 14.294-52.954 51.655 63.675 129.3 105.258 216.365 109.807-1.624-7.797-2.599-15.918-2.599-24.04 0-57.828 46.782-104.934 104.934-104.934 30.213 0 57.502 12.67 76.67 33.137 23.715-4.548 46.456-13.32 66.599-25.34-7.798 24.366-24.366 44.833-46.132 57.827 21.117-2.273 41.584-8.122 60.426-16.243-14.292 20.791-32.161 39.308-52.628 54.253z"
            ></path></svg
          ><!-- <i class="fab fa-twitter"></i> Font Awesome fontawesome.com -->
          サービスをシェアする！</a
        >
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
