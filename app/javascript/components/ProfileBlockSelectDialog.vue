<template>
  <div>
    <v-dialog
      :value="isShownProfileBlockSelectDialog"
      max-width="800"
      persistent
      @input="$emit('input', $event.target.isShownProfileBlockSelectDialog)"
    >
      <v-card class="bg-prof-card bg-top">
        <p
          class="font-weight-bold font-prof-default text-gray-600 text-4xl text-center mt-10 mb-10"
        >
          フォーマットを選択してください
        </p>
        <v-row>
          <v-col
            v-for="n in 1"
            :key="n"
            cols="12"
            sm="6"
          >
            <v-card
              class="mx-auto"
              max-width="400"
            >
              <v-img
                class="white--text align-end"
                height="200px"
                :src="require('../tail_images/text_block.png')"
              >
                <v-card-title
                  class="font-prof-default"
                >
                  テキストフォーマット
                </v-card-title>
              </v-img>

              <v-card-text class="font-prof-default text-gray-600">
                <div>用途: 自己紹介などの長い文章を書く</div>
              </v-card-text>

              <v-card-actions>
                <v-btn
                  color="blue-grey darken-2"
                  class="font-prof-default white--text"
                  @click="openTextFormatDialog"
                >
                  <v-icon left>
                    mdi-pencil
                  </v-icon>
                  このフォーマットを使う
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-col>
        </v-row>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
export default {
  props: {
    isShownProfileBlockSelectDialog: {
      type: Boolean,
      required: true,
    },
  },
  methods: {
    openTextFormatDialog() {
      this.$emit("open-text-format-dialog");
    }
  },
};
</script>
