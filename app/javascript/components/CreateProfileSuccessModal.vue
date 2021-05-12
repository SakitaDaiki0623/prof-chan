<template>
  <div>
    <v-dialog
      :value="isShownCreateProfileSuccessDialog"
      persistent
      max-width="800"
      @input="$emit('input', $event.target.isShownCreateProfileSuccessDialog)"
    >
      <v-card height="550">
        <p
          class="font-weight-bold  text-gray-600 text-4xl text-center mt-20 mb-10"
        >
          基本情報の登録が完了しました！
        </p>
        <v-card-actions>
          <v-row justify="center" class="p-8">
            <v-btn
              x-large
              color="light-green accent-2"
              class=" black--text"
              @click="moveToProfilesPage"
            >
              <v-icon left> mdi-account-circle </v-icon>
              プロフィール閲覧
            </v-btn>
          </v-row>
        </v-card-actions>
        <v-card-text class=" text-gray-600 text-center mb-5">
          他の社員プロフィールを閲覧します。
        </v-card-text>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";

export default {
  props: {
    isShownCreateProfileSuccessDialog: {
      type: Boolean,
      required: true,
    },
  },
  computed: {
    ...mapState("users", ["currentUser"]),
  },
  methods: {
    moveToProfilesPage() {
      this.$router.push("/profiles");
    },
  },
};
</script>
