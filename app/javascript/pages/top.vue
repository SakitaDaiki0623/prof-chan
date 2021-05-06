<template>
  <div class="top">
    <div class="top-bg">
      <div class="border-t-2 border-pink-500 border-dashed">
        <v-row>
          <v-col cols="12" sm="12">
            <div class="text-center text-3xl">
              - - - - REMOTELY PROMOTE YOURSELF.- - - -
            </div>
          </v-col>
          <v-col cols="12" sm="8">
            <div class="text-center py-20">
              <div class="text-lg">
                コロナ時代のフルリモート社員に贈る社員プロフィール公開サービス
              </div>
              <div class="text-8xl p-10 font-body">プロフちゃん</div>
              <a
                class="inline-block"
                rel="nofollow"
                data-method="post"
                href="/users/auth/slack"
                ><img
                  alt="Sign in with Slack"
                  height="60"
                  width="200"
                  src="https://platform.slack-edge.com/img/sign_in_with_slack.png"
                  srcset="
                    https://platform.slack-edge.com/img/sign_in_with_slack.png    1x,
                    https://platform.slack-edge.com/img/sign_in_with_slack@2x.png 2x
                  "
              /></a>
            </div>
          </v-col>
          <v-col cols="12" sm="4"
            ><div class="py-32">プロフちゃんの画像</div>
          </v-col>
        </v-row>
      </div>
    </div>
    <div class="p-20 text-center">
      <v-row class="px-20">
        <v-col cols="12" sm="12">
          <div class="text-3xl top-sub-title mb-10">
            リモートで会えない他の社員に自分のプロフィールを公開しよう
          </div>
        </v-col>
        <v-col cols="12" sm="5" justify="center">
          <img src="../images/undraw_swipe_profiles1_i6mr.svg" class="h-80" />
        </v-col>
        <v-col cols="12" sm="7" align-self="center">
          <div class="text-lg text-center px-5 py-15 bg-white rounded-full">
            プロフちゃんはコロナ下で減ってしまった雑談を補完するために<br />社内でプロフィールを公開する社員プロフィール公開サービスです。<br />
            自分の趣味や好きなことをプロフィールに書いて<br />他の人が知らないあなたの情報をプロフィールに記録しよう！
          </div>
        </v-col>
        <v-col cols="12" sm="12">
          <div class="text-3xl top-sub-title mb-10">
            昔流行したプロフィール帳を再現！
          </div>
        </v-col>
        <v-col cols="12" sm="7" align-self="center">
          <div class="text-lg text-center px-5 py-15 bg-white rounded-full">
            作成するプロフィールはプロフィール帳を参考にしています。<br />ノートに書き込む感覚で楽しくプロフィールを作成できます。<br />
          </div>
        </v-col>
        <v-col cols="12" sm="5">
          <img src="../images/undraw_Notebook_re_id0r.svg" class="h-80" />
        </v-col>
      </v-row>
    </div>
  </div>
</template>

<script>
export default {};
</script>

<style scoped>
.top {
  color: rgb(77, 77, 77);
}

.top-bg {
  background-color: #efebe9;
  height: 560px;
  padding: 2rem;
}

.top-sub-title {
  position: relative;
  background: #a1887f;
  box-shadow: 0px 0px 0px 5px #a1887f;
  border: dashed 2px white;
  padding: 0.2em 0.5em;
  color: white;
}
</style>
