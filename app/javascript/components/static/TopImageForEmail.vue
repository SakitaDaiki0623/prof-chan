<template>
  <div>
    <div class="top-bg">
      <div class="border-t-2 border-pink-500 border-dashed">
        <v-row justify="center" align-content="center">
          <v-col cols="12" sm="12">
            <div class="text-center text-lg md:text-2xl lg:text-4xl">
              - - - - REMOTELY PROMOTE YOURSELF.- - - -
            </div>
          </v-col>
          <v-col cols="12" sm="12" md="7">
            <div class="text-center bg-white rounded-full md:p-10 m-5">
              <div class="text-md lg:text-xl mb-5">
                コロナ時代のフルリモート社員に贈る
                <br />
                社員プロフィール公開サービス
              </div>
              <div class="text-4xl font-bold md:text-5xl lg:text-6xl">
                プロフちゃん
              </div>
            </div>
          </v-col>
          <v-col cols="12" sm="4" md="5">
            <div class="balloon1 text-sm text-center md:text-3xl">通常ログイン版</div>
            <img src="../../images/prof_happy.png" class="max-w-xs mx-auto md:max-w-sm" />
          </v-col>
        </v-row>
      </div>
    </div>
    <div class="bg-brown-500 p-10">
      <v-row justify="center" align-content="center">
        <v-col cols="12" sm="5" class="border-white border-dotted border-2">
          <div>
            <div class="text-white text-2xl text-center">
              こちらは通常ログイン版の画面です。<br />
              全てのユーザのプロフィールを閲覧することができます。<br />
              社内でのみプロフを公開したい場合は、ホーム画面に戻り「Sign in with
              slack」をご利用ください。
            </div>
          </div>
          <v-col cols="12" align="center">
            <a class="sign-in-with-slack-button"
              ><img
                height="40"
                width="172"
                src="https://platform.slack-edge.com/img/sign_in_with_slack.png"
                srcset="
                  https://platform.slack-edge.com/img/sign_in_with_slack.png    1x,
                  https://platform.slack-edge.com/img/sign_in_with_slack@2x.png 2x
                "
            /></a>
          </v-col>
        </v-col>
      </v-row>
    </div>
  </div>
</template>

<script>
export default {};
</script>

<style scoped>
.top-bg {
  background-color: #efebe9;
  height: 560px;
  padding: 2rem;
}

.balloon1 {
  position: relative;
  display: inline-block;
  min-width: 170px;
  color: #bcaaa4;
  background: #ffffff;
  border-radius: 15px;
}

.balloon1:before {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -15px;
  border: 15px solid transparent;
  border-top: 15px solid #ffffff;
}

.sign-in-with-slack-button {
  pointer-events: none;
}
</style>
