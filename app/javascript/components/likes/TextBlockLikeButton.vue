<template>
  <div>
    <div v-if="isLiked">
      <v-btn icon color="teal lighten-3" @click="deleteLike()">
        <v-icon>mdi-bookmark</v-icon>
      </v-btn>
    </div>
    <div v-else>
      <v-btn icon @click="registerLike()">
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
    textBlockId: {
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
    this.fetchLikeByTextBlockId().then((result) => {
      this.likeList = result;
    });
  },
  methods: {
    fetchLikeByTextBlockId: async function() {
      const res = await axios.get(
        `/api/v1/likes/text_block_likes/?text_block_id=${this.textBlockId}`
      );
      if (res.status !== 200) {
        process.exit();
      }
      return res.data;
    },

    registerLike: async function() {
      const res = await axios.post("/api/v1/likes/text_block_likes", {
        text_block_id: this.textBlockId,
      });
      if (res.status !== 201) {
        process.exit();
      }
      this.fetchLikeByTextBlockId().then((result) => {
        this.likeList = result;
      });
    },

    deleteLike: async function() {
      const likeId = this.findLikeId();
      const res = await axios.delete(
        `/api/v1/likes/text_block_likes/${likeId}`
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
