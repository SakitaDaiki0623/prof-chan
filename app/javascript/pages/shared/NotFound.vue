<template>
  <v-container class="pt-10 pb-5 text-center">
    <h1 class="display-3 font-bold">
      404 Not Found
    </h1>
    <div class="mt-10 mb-10">
      <v-row>
        <v-col cols="12" sm="6" align="right">
          <img src="../../images/prof_sad.png" class="md:max-w-sm mx-auto" />
        </v-col>
        <v-col cols="12" sm="6">
          <div class="balloon4 text-xl sm:text-md md:text-3xl px-3 pt-2">
            <p>お探しのページが見つかりませんでした。</p>
            <p>
              一時的にアクセスができない状況にあるか
              <br
                class="d-flex d-sm-none"
              />移動もしくは削除された可能性があります。
            </p>
            <p>URLにお間違いがないか再度ご確認ください。</p>
          </div>
        </v-col>
      </v-row>
    </div>
    <v-btn
      color="brown"
      class="white--text text-center mb-20"
      depressed
      :to="{ path: '/top' }"
    >
      <v-icon left> mdi-exit-run </v-icon>トップページに戻る
    </v-btn>
  </v-container>
</template>

<script>
export default {
  mounted() {
    document.title = "ページが見つかりません - プロフちゃん";
  },
};
</script>

<style scoped>
.balloon4 {
  position: relative;
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
.content {
  margin: 0 auto;
  max-width: 550px;
}
</style>
