<template>
  <!-- Item Form -->
  <ValidationObserver ref="observer" v-slot="{ invalid }">
    <form id="individual-create-yes-or-no-block-item-form">
      <div class="ma-1">
        <v-row>
          <v-col cols="12" md="6">
            <label for="yes_or_no_item_content" class="form-label-text-block"
              >質問</label
            >
            <ValidationProvider
              v-slot="{ errors }"
              name="質問"
              rules="input_required|max:20"
            >
              <input
                v-model="yesOrNoItem.content"
                class="input-form-yes-or-no-block"
                name="yes_or_no_item[yes_or_no_item_content]"
                type="text"
              />
              <span class="red--text text-sm">{{ errors[0] }}</span>
            </ValidationProvider>
          </v-col>
          <v-col cols="12" md="6">
            <label for="yes_or_no_item_content" class="form-label-text-block"
              >答え</label
            >
            <v-radio-group v-model="yesOrNoItem.answer" mandatory row>
              <v-radio
                label="YES"
                :value="true"
                color="orange"
                class="yes-for-rspec"
              />
              <v-radio
                label="NO"
                :value="false"
                color="orange"
                class="no-for-rspec"
              />
            </v-radio-group>
          </v-col>
        </v-row>
        <v-row justify="end">
          <v-col cols="12" md="2">
            <v-btn
              tile
              large
              color="orange lighten-4"
              :disabled="invalid"
              @click="hundleCreateIndevisialYesOrNoItem(yesOrNoItem)"
            >
              作成！
            </v-btn>
          </v-col>
        </v-row>
      </div>
    </form>
  </ValidationObserver>
</template>

<script>
import axios from "axios";

export default {
  props: {
    parentYesOrNoBlockId: {
      type: Number,
      required: true,
    },
  },
  data() {
    return {
      yesOrNoItem: {
        content: "",
        answer: "",
        yes_or_no_block_id: this.parentYesOrNoBlockId,
      },
    };
  },
  methods: {
    hundleCreateIndevisialYesOrNoItem(yesOrNoItem) {
      this.createYesOrNoItem(yesOrNoItem);
      this.resetYesOrNoItem();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "Yes or No アイテムを作成したよ！",
        color: "orange lighten-3",
      });
    },

    createYesOrNoItem(yesOrNoItem) {
      axios.post("/api/v1/yes_or_no_items", yesOrNoItem).then((response) => {
        this.$emit("add-yes-or-no-item", response.data);
      });
    },
    resetYesOrNoItem() {
      this.yesOrNoItem.content = "";
      this.yesOrNoItem.answer = "";
      requestAnimationFrame(() => {
        this.$refs.observer.reset();
      });
    },
  },
};
</script>
