<template>
  <v-container>
    <v-row>
      <v-col
        v-for="yesOrNoBlock in myYesOrNoBlocks"
        :key="yesOrNoBlock.id"
        cols="12"
        sm="6"
      >
        <v-card class="bg-yes-or-no-prof-block bg-cover shadow rounded-2xl p-5">
          <v-row justify="end">
            <v-btn
              :id="'edit-yes-or-no-block-button-' + yesOrNoBlock.id"
              tile
              small
              color="orange lighten-4"
              @click="openEditYesOrNoFormatDialog(yesOrNoBlock)"
            >
              <v-icon> mdi-pencil </v-icon>
            </v-btn>
            <v-btn
              :id="'delete-yes-or-no-block-button-' + yesOrNoBlock.id"
              tile
              small
              color="orange lighten-1"
              @click="hundleDeleteYesOrNoBlock(yesOrNoBlock)"
            >
              <v-icon> mdi-delete </v-icon>
            </v-btn>
          </v-row>
          <p class="text-2xl font-bold text-gray-600 pt-3">
            {{ yesOrNoBlock.title }}
          </p>
          <template v-for="yes_or_no_item in yesOrNoBlock.yes_or_no_items">
            <div :key="yes_or_no_item.id">
              <v-card class="p-5 rounded-lg" outlined>
                <v-row>
                  <v-col cols="12" sm="6">
                    {{ yes_or_no_item.content }}
                  </v-col>
                  <v-col
                    cols="12"
                    sm="6"
                    v-if="yes_or_no_item.answer"
                  >
                    <span class="rounded-full border-red-500 border-2 p-2">YES</span>  /  NO
                  </v-col>
                  <v-col cols="12" sm="6" v-else>
                    YES  /  <span class="rounded-full border-red-500 border-2 p-2">NO</span>
                  </v-col>
                </v-row>
              </v-card>
            </div>
          </template>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapState, mapActions } from "vuex";

export default {
  computed: {
    ...mapState("yesOrNoBlocks", ["yesOrNoBlocks"]),
    ...mapState("users", ["currentUser"]),

    myYesOrNoBlocks() {
      return (
        this.yesOrNoBlocks.filter(
          (yesOrNoBlock) =>
            yesOrNoBlock.profile_block.id == this.currentUser.profile_block.id
        ) || {}
      );
    },
  },
  methods: {
    openEditYesOrNoFormatDialog(yesOrNoBlock) {
      this.$emit("open-edit-yes-or-no-format-dialog", yesOrNoBlock);
    },
    hundleDeleteYesOrNoBlock(yesOrNoBlock) {
      this.$emit("delete-yes-or-no-block", yesOrNoBlock);
    },
  },
};
</script>

<style scoped>
.bg-yes-or-no-prof-block {
  background: linear-gradient(#ccc 0.1px, transparent 0.6px) #fffbf2;
  background-size: auto 2.5em;
  line-height: 2.5em;
  border-bottom: 1px solid #ccc;
  border-left: 1px solid #ccc;
  border-right: 1px solid #ccc;
  overflow: hidden;
}
</style>
