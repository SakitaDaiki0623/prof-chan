<template>
  <div>
    <v-dialog
      persistent
      max-width="800"
    >
      <v-card
        height="450"
        :img="require('../tail_images/card_bg.jpg')"
      >
        <p
          class="font-weight-bold font-prof-default text-gray-600 text-4xl text-center mt-20 mb-10"
        >
          基本情報の登録が完了しました！
        </p>
        <v-row justify="space-around">
          <v-card-actions>
            <div>
              <v-btn
                x-large
                color="blue-grey darken-2"
                class="font-prof-default white--text"
              >
                <v-icon left>
                  mdi-pencil
                </v-icon>
                他の情報も入力する
              </v-btn>
            </div>
          </v-card-actions>
          <v-card-text class="font-prof-default text-gray-600 text-center mb-5">
            趣味、住所などあなたに関わるプロフィールを追加します。
          </v-card-text>
          <v-card-actions>
            <v-btn
              x-large
              color="light-green accent-2"
              class="font-prof-default black--text"
              @click="moveToProfilesPage"
            >
              <v-icon left>
                mdi-account-circle
              </v-icon>
              プロフィール閲覧
            </v-btn>
          </v-card-actions>
          <v-card-text class="font-prof-default text-gray-600 text-center mb-5">
            他の社員プロフィールを閲覧します。
          </v-card-text>
        </v-row>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
export default {
  props: {
    isShownCreateProfileSuccessDialog: {
      type: Boolean,
      required: true,
    },
  },
  methods: {
    moveToProfilesPage() {
      this.$router.push("/profiles");
    },
  },
};
</script>
