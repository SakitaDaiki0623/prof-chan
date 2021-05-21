<template>
  <div>
    <v-dialog
      :value="isShownCreateProfileSuccessDialog"
      persistent
      max-width="1000"
      @input="$emit('input', $event.target.isShownCreateProfileSuccessDialog)"
    >
      <div class="bg-brown-100">
        <div
          class="font-weight-bold  text-gray-600 text-4xl text-center bg-brown-200 py-10"
        >
          基本情報の入力が完了しました
        </div>
        <v-card color="brown lighten-2" outlined>
          <v-row align="center" align-content="center">
            <v-col cols="12" sm="6" align="right">
              <img src="../images/prof_happy.png" class="max-w-sm" />
            </v-col>
            <v-col cols="12" sm="6">
              <p
                class="text-2xl bg-brown-100 text-gray-600 text-center p-10 rounded-full max-w-sm font-weight-bold"
              >
                プロフちゃんの世界へようこそ！
              </p>
              <v-card-actions>
                <v-btn
                  x-large
                  color="brown accent-2"
                  class=" white--text"
                  @click="moveToTopPage"
                >
                  トップページに行く
                </v-btn>
              </v-card-actions>
            </v-col>
          </v-row>
        </v-card>
      </div>
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
    moveToTopPage() {
      this.$router.push("/top");
    },
  },
};
</script>

<style scoped></style>
