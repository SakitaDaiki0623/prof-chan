<template>
  <div>
    <div v-if="isLiked">
      <v-btn icon color="teal lighten-3" @click="deleteLike()">
        <v-icon>mdi-thumb-up</v-icon>
      </v-btn>
      {{ likeCount }}
    </div>
    <div v-else>
      <v-btn icon @click="registerLike()">
        <v-icon>mdi-thumb-up</v-icon>
      </v-btn>
      {{ likeCount }}
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";

export default {
  props: {
    rankingBlockId: {
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
    this.fetchLikeByRankingBlockId().then((result) => {
      this.likeList = result;
    });
  },
  methods: {
    fetchLikeByRankingBlockId: async function() {
      const res = await axios.get(
        `/api/v1/likes/ranking_block_likes/?ranking_block_id=${this.rankingBlockId}`
      );
      if (res.status !== 200) {
        process.exit();
      }
      return res.data;
    },

    registerLike: async function() {
      const res = await axios.post("/api/v1/likes/ranking_block_likes", {
        ranking_block_id: this.rankingBlockId,
      });
      if (res.status !== 201) {
        process.exit();
      }
      this.fetchLikeByRankingBlockId().then((result) => {
        this.likeList = result;
      });
    },

    deleteLike: async function() {
      const likeId = this.findLikeId();
      const res = await axios.delete(
        `/api/v1/likes/ranking_block_likes/${likeId}`
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
