<template>
  <div class="top">
    <div class="top-bg">
      <div>
        <v-row>
          <v-col cols="12" sm="12">
            <div class="text-center text-5xl">
              - - - - おすすめ社員リスト- - - -
            </div>
          </v-col>
        </v-row>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      datas: [],
      questionPopularBlocks: [],
      rankingPopularBlocks: [],
      yesOrNoPopularBlocks: [],
      textPopularBlocks: [],
    };
  },
  mounted() {
    this.firstRead();
  },
  methods: {
    async firstRead() {
      await this.tekito();
      console.log(this.textPopularBlocks);
    },
    async tekito() {
      console.log(this.textPopularBlocks);
      await axios
        .get("/api/v1/likes/question_block_likes/liked_user")
        .then((res) => (this.textPopularBlocks = res.data));
    },
  },
};
</script>

<style scoped>
.top {
  color: rgb(77, 77, 77);
}

.top-bg {
  background-color: #efebe9;
  padding: 2rem;
}
</style>
