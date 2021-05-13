// app/javascript/store/modules/yesOrNoBlocks.js
import axios from "../../plugins/axios.js";

export const yesOrNoBlocks = {
  namespaced: true,
  state: {
    yesOrNoBlocks: [],
    yesOrNoItems: [],
  },
  mutations: {
    // yesOrNo Blocks ===========================
    loadYesOrNoBlocks(state, yesOrNoBlocks) {
      state.yesOrNoBlocks = yesOrNoBlocks;
    },
    addYesOrNoBlock: (state, yesOrNoBlock) => {
      state.yesOrNoBlocks.push(yesOrNoBlock);

      // 従属アイテムの追加
      yesOrNoBlock.yes_or_no_items.forEach((yesOrNoItem) =>
        state.yesOrNoItems.push(yesOrNoItem)
      );
    },
    updateYesOrNoBlock(state, data) {
      const index = state.yesOrNoBlocks.findIndex((yesOrNoBlock) => {
        return yesOrNoBlock.id == data.id;
      });
      state.yesOrNoBlocks.splice(index, 1, data);
    },
    retrieveYesOrNoBlock(state, data) {
      const index = state.yesOrNoBlocks.findIndex((yesOrNoBlock) => {
        return yesOrNoBlock.id == data.id;
      });
      state.yesOrNoBlocks.splice(index, 1);

      // 従属アイテムの削除
      state.yesOrNoItems = state.yesOrNoItems.filter(
        (yesOrNoItem) => yesOrNoItem.yes_or_no_block.id !== data.id
      );
    },

    // yesOrNo Items ===========================
    loadYesOrNoItems(state, yesOrNoItems) {
      state.yesOrNoItems = yesOrNoItems;
    },
    addYesOrNoItem: (state, yesOrNoItem) => {
      state.yesOrNoItems.push(yesOrNoItem);

      // 作成したアイテムを持つYes or No ブロックのインデックス番号を取得
      const yesOrNoBlockIndex = state.yesOrNoBlocks.findIndex(
        (yesOrNoBlock) => yesOrNoBlock.id == yesOrNoItem.yes_or_no_block.id
      );

      state.yesOrNoBlocks[yesOrNoBlockIndex].yes_or_no_items.push(yesOrNoItem);
    },
    updateYesOrNoItem(state, data) {
      const yesOrNoItemsIndex = state.yesOrNoItems.findIndex((yesOrNoItem) => {
        return yesOrNoItem.id == data.id;
      });
      state.yesOrNoItems.splice(yesOrNoItemsIndex, 1, data);

      // 更新したアイテムを持つYes or No ブロックのインデックス番号を取得
      const yesOrNoBlockIndex = state.yesOrNoBlocks.findIndex(
        (yesOrNoBlock) => yesOrNoBlock.id == data.yes_or_no_block.id
      );

      // そのYes or No ブロック内の更新したアイテムのインデックス番号を取得
      const yesOrNoBlockItemsIndex = state.yesOrNoBlocks
        .find((yesOrNoBlock) => yesOrNoBlock.id == data.yes_or_no_block.id)
        .yes_or_no_items.findIndex((yesOrNoItem) => yesOrNoItem.id == data.id);

      state.yesOrNoBlocks[yesOrNoBlockIndex].yes_or_no_items.splice(
        yesOrNoBlockItemsIndex,
        1,
        data
      );
    },

    retrieveYesOrNoItem(state, data) {
      const index = state.yesOrNoItems.findIndex((yesOrNoItem) => {
        return yesOrNoItem.id == data.id;
      });
      state.yesOrNoItems.splice(index, 1);

      // 削除したアイテムを持つYes or No ブロックのインデックス番号を取得
      const yesOrNoBlockIndex = state.yesOrNoBlocks.findIndex(
        (yesOrNoBlock) => yesOrNoBlock.id == data.yes_or_no_block.id
      );

      // そのYes or No ブロック内の削除したアイテムのインデックス番号を取得
      const yesOrNoBlockItemsIndex = state.yesOrNoBlocks
        .find((yesOrNoBlock) => yesOrNoBlock.id == data.yes_or_no_block.id)
        .yes_or_no_items.findIndex((yesOrNoItem) => yesOrNoItem.id == data.id);

      state.yesOrNoBlocks[yesOrNoBlockIndex].yes_or_no_items.splice(
        yesOrNoBlockItemsIndex,
        1
      );
    },
  },
  actions: {
    // yesOrNo Blocks ===========================
    fetchYesOrNoBlocks({ commit }) {
      axios
        .get("yes_or_no_blocks")
        .then((response) => {
          commit("loadYesOrNoBlocks", response.data);
        })
        .catch((error) => console.log(error.status));
    },
    createYesOrNoBlock({ commit }, params) {
      axios
        .post("yes_or_no_blocks", params)
        .then((response) => {
          commit("addYesOrNoBlock", response.data);
        })
        .catch((err) => console.log(err.status));
    },
    patchYesOrNoBlock({ commit }, payload) {
      axios
        .patch(`yes_or_no_blocks/${payload.id}`, payload)
        .then((response) => {
          commit("updateYesOrNoBlock", response.data);
        })
        .catch((err) => console.log(err));
    },

    deleteYesOrNoBlock({ commit }, payload) {
      axios
        .delete(`yes_or_no_blocks/${payload.id}`, payload)
        .then((response) => {
          commit("retrieveYesOrNoBlock", response.data);
        })
        .catch((err) => console.log(err));
    },

    // yesOrNo Items ===========================
    fetchYesOrNoItems({ commit }) {
      axios
        .get("yes_or_no_items")
        .then((response) => {
          commit("loadYesOrNoItems", response.data);
        })
        .catch((error) => console.log(error.status));
    },
    createYesOrNoItem({ commit }, yesOrNoItem) {
      axios
        .post("yes_or_no_items", yesOrNoItem)
        .then((response) => {
          commit("addYesOrNoItem", response.data);
        })
        .catch((error) => console.log(error.status));
    },
    patchYesOrNoItem({ commit }, payload) {
      axios
        .patch(`yes_or_no_items/${payload.id}`, payload)
        .then((response) => {
          commit("updateYesOrNoItem", response.data);
        })
        .catch((err) => console.log(err));
    },
    deleteYesOrNoItem({ commit }, payload) {
      axios
        .delete(`yes_or_no_items/${payload.id}`, payload)
        .then((response) => {
          commit("retrieveYesOrNoItem", response.data);
        })
        .catch((err) => console.log(err));
    },
  },
};
