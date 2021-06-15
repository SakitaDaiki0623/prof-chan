<template>
  <div>
    <div v-if="isLiked">
      <v-btn
        icon
        color="orange lighten-2"
        @click="deleteLike()"
      >
        <v-icon>mdi-bookmark</v-icon>
      </v-btn>
    </div>
    <div v-else>
      <v-btn
        icon
        @click="registerLike()"
      >
        <v-icon>mdi-bookmark-plus-outline</v-icon>
      </v-btn>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";

export default {
  props: {
    yesOrNoBlockId: {
      type: Number,
      required: true,
    },
  },
  data() {
    return {
      likeList: [],
    };
  },
  computed: {
    ...mapState("users", ["currentUser"]),

    userId() {
      return this.currentUser.id;
    },

    likeCount() {
      return this.likeList.length;
    },
    isLiked() {
      if (this.likeList.length === 0) {
        return false;
      }
      return Boolean(this.findLikeId());
    },
  },

  created: function() {
    this.fetchLikeByYesOrNoBlockId().then((result) => {
      this.likeList = result;
    });
  },
  methods: {
    fetchLikeByYesOrNoBlockId: async function() {
      const res = await axios.get(
        `/api/v1/likes/yes_or_no_block_likes/?yes_or_no_block_id=${this.yesOrNoBlockId}`
      );
      if (res.status !== 200) {
        process.exit();
      }
      return res.data;
    },

    registerLike: async function() {
      const res = await axios.post("/api/v1/likes/yes_or_no_block_likes", {
        yes_or_no_block_id: this.yesOrNoBlockId,
      });
      if (res.status !== 201) {
        process.exit();
      }
      this.fetchLikeByYesOrNoBlockId().then((result) => {
        this.likeList = result;
      });
    },

    deleteLike: async function() {
      const likeId = this.findLikeId();
      const res = await axios.delete(
        `/api/v1/likes/yes_or_no_block_likes/${likeId}`
      );
      if (res.status !== 200) {
        process.exit();
      }
      this.likeList = this.likeList.filter((n) => n.id !== likeId);
    },

    findLikeId: function() {
      const like = this.likeList.find((like) => {
        return like.user_id === this.userId;
      });
      if (like) {
        return like.id;
      }
    },
  },
};
</script>
