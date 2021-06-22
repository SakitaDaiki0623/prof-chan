<template>
  <div
    :id="yesOrNoBlockItemId"
    class="ma-1"
  >
    <!-- Item Form -->
    <v-row
      v-show="!isTheItemEditing"
      align="center"
      justify="center"
    >
      <v-col
        cols="12"
        md="10"
      >
        <v-card
          class="pa-5 rounded-lg"
          outlined
        >
          <v-row>
            <v-col
              cols="12"
              sm="6"
            >
              {{ yesOrNoItem.content }}
            </v-col>
            <v-col
              v-if="yesOrNoItem.answer"
              cols="12"
              sm="6"
            >
              <span class="rounded-full border-brown-500 border-2 pa-2">YES</span>
              / NO
            </v-col>
            <v-col
              v-else
              cols="12"
              sm="6"
            >
              YES /
              <span class="rounded-full border-brown-500 border-2 pa-2">NO</span>
            </v-col>
          </v-row>
        </v-card>
      </v-col>

      <v-col
        cols="12"
        md="1"
      >
        <v-btn
          :id="'edit-yes-or-no-item-button-' + yesOrNoItem.id"
          tile
          small
          color="orange lighten-4"
          @click="showEditYesOrNoItemForm"
        >
          <v-icon> mdi-pencil </v-icon>
        </v-btn>
      </v-col>
      <v-col
        cols="12"
        md="1"
      >
        <v-btn
          :id="'delete-yes-or-no-item-button-' + yesOrNoItem.id"
          tile
          small
          color="orange lighten-1"
          :disabled="IsItemLengthOne"
          @click="hundleDeleteYesOrNoItem(yesOrNoItem)"
        >
          <v-icon> mdi-delete </v-icon>
        </v-btn>
      </v-col>
    </v-row>

    <!-- Item Form -->
    <div v-show="isTheItemEditing">
      <ValidationObserver
        ref="observer"
        v-slot="{ invalid }"
      >
        <form>
          <v-row>
            <v-col
              cols="12"
              md="6"
            >
              <label
                for="yes_or_no_item_content"
                class="form-label-text-block"
              >質問</label>
              <ValidationProvider
                v-slot="{ errors }"
                :name="yesOrNoNameForValidation"
                rules="input_required|max:50"
              >
                <input
                  :id="'edit-yes-or-no-item-content-form-' + editYesOrNoItem.id"
                  :value="editYesOrNoItem.content"
                  class="input-form-yes-or-no-block"
                  name="yes_or_no_item[yes_or_no_item_content]"
                  type="text"
                  @input="editYesOrNoItem.content = $event.target.value"
                >
                <span class="red--text text-sm">{{ errors[0] }}</span>
              </ValidationProvider>
            </v-col>
            <v-col
              cols="12"
              md="6"
            >
              <label
                for="yes_or_no_item_answer"
                class="form-label-text-block inline-block"
              >
                答え
              </label>
              <v-radio-group
                v-model="editYesOrNoItem.answer"
                mandatory
                row
              >
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
            <v-col
              cols="12"
              md="1"
            >
              <v-btn
                :id="'update-yes-or-no-item-button-' + editYesOrNoItem.id"
                tile
                small
                color="orange lighten-4"
                :disabled="invalid"
                @click="hundleUpdateYesOrNoItem(editYesOrNoItem)"
              >
                更新
              </v-btn>
            </v-col>
            <v-col
              cols="12"
              md="1"
            >
              <v-btn
                :id="
                  'cancel-yes-or-no-item-update-button-' + editYesOrNoItem.id
                "
                tile
                small
                color="orange darken-1"
                @click="cancelYesOrNoItemUpdate"
              >
                ×
              </v-btn>
            </v-col>
          </v-row>
        </form>
      </ValidationObserver>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";

export default {
  props: {
    yesOrNoItem: {
      type: Object,
      require: true,
    },
    yesOrNoNameForValidation: {
      type: String,
      require: true,
    },
    answerNameForValidation: {
      type: String,
      require: true,
    },
    yesOrNoItemLength: {
      type: Number,
      require: false,
    },
    isTheItemEditing: {
      type: Boolean,
      require: false,
    },
    yesOrNoBlockItemId: {
      type: String,
      require: true,
    },
    yesOrNoBlockColor: {
      type: String,
      require: true,
    },
  },
  data() {
    return {};
  },
  computed: {
    editYesOrNoItem: {
      get() {
        return Object.assign({}, this.yesOrNoItem);
      },
      set(newValue) {
        const content = newValue.content;
        const answer = newValue.answer;
        this.content = content;
        this.answer = answer;
      },
    },
    IsItemLengthOne() {
      return this.yesOrNoItemLength == 1 ? true : false;
    },
  },
  methods: {
    ...mapActions({
      patchYesOrNoItem: "yesOrNoBlocks/patchYesOrNoItem",
      deleteYesOrNoItem: "yesOrNoBlocks/deleteYesOrNoItem",
    }),
    showEditYesOrNoItemForm() {
      this.$emit("show-edit-yes-or-no-item-form");
    },
    hideEditYesOrNoForm() {
      this.$emit("hide-edit-yes-or-no-item-form");
    },

    cancelYesOrNoItemUpdate() {
      this.hideEditYesOrNoForm();
      requestAnimationFrame(() => {
        this.$refs.observer.reset();
      });
    },

    hundleUpdateYesOrNoItem(yesOrNoItem) {
      this.patchYesOrNoItem(yesOrNoItem);
      this.editYesOrNoItem = yesOrNoItem;
      this.hideEditYesOrNoForm();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "Yes or No アイテムを更新したよ！",
        color: this.yesOrNoBlockColor,
      });
    },

    // 削除
    hundleDeleteYesOrNoItem(yesOrNoItem) {
      this.deleteYesOrNoItem(yesOrNoItem);
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "Yes or No アイテムを削除したよ！",
        color: this.yesOrNoBlockColor,
      });
    },
  },
};
</script>
