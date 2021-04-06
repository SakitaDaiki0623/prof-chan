<template>
  <div class="font-prof-default">
    <v-row justify="center">
      <v-dialog
        v-model="isShownCreateProfileSuccessDialog"
        persistent
        max-width="800"
      >
        <v-card height="450" :img="require('../tail_images/card_bg.jpg')">
          <v-card-title class="headline">
            基本情報の登録が完了しました！
          </v-card-title>
          <v-card-text>
            趣味、住所などあなたに関わるプロフィールを追加します。
          </v-card-text>
          <v-card-actions>
            <div class="text-center mt-3">
              <v-btn
                id="creation_button"
                type="submit"
                depressed
                elevation="4"
                large
                color="lime lighten-5"
                >入力完了！</v-btn
              >
            </div>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-row>
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
};
</script>
