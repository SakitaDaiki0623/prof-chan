<template>
  <v-container>
    <v-row justify="center" align-content="center" class="h-96 p-20">
      <v-col cols="12" sm="6" align="right">
        <img src="../images/prof_normal.png" class="image" />
      </v-col>
      <v-col cols="12" sm="6" align="left">
        <div class="text-center text-4xl balloon4">
          {{ profMessage }}
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    profMessage: {
      type: String,
      required: false,
      default: "ブックマークボタンを押したブロックはまだないよ",
    },
  },
};
</script>
<style scoped>
.image {
  max-width: 20rem;
}

.balloon4 {
  position: relative;
  margin: 2em 4em 2em 40px;
  padding: 15px;
  background: #fff0c6;
  border-radius: 30px;
}

.balloon4:before {
  content: "";
  position: absolute;
  left: -38px;
  width: 13px;
  height: 12px;
  bottom: 0;
  background: #fff0c6;
  border-radius: 50%;
}

.balloon4:after {
  content: "";
  position: absolute;
  left: -24px;
  width: 20px;
  height: 18px;
  bottom: 3px;
  background: #fff0c6;
  border-radius: 50%;
}

.balloon4 div {
  margin: 0;
  padding: 0;
}
</style>
