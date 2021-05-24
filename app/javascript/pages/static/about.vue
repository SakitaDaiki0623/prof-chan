<template>
  <div class="text-center text-gray-600">
    <v-row justify="center" align-content="center" class=" my-10">
      <v-col
        cols="12"
        sm="12"
        class="mb-20 bg-brown-500 h-80 text-white"
        align="center"
        align-self="end"
      >
        <div class="text-2xl border-b-8 border-white pb-2 inline-block">
          THEME
        </div>
        <div class="text-4xl pt-10">
          - - - - REMOTELY PROMOTE YOURSELF.- - - -
        </div>
        <div class="text-6xl pt-10">
          コロナ以前の雑談の補完。
        </div>
      </v-col>
      <v-col cols="12" sm="12" class="mb-20">
        <div class="text-6xl">
          プロフちゃんはコロナで減ってしまった雑談を補完する<br /><span
            class="border-b-8 border-brown-500"
          >
            「社内プロフィール公開サービス」</span
          >です。
        </div>
      </v-col>

      <!-- 説明欄1 -->
      <v-col cols="12" sm="12" align="left" class="mb-60">
        <v-card
          height="500px"
          color="brown lighten-3"
          outlined
          align="center"
          class="p-10"
        >
          <div
            class="text-4xl border-t-8 border-b-8 border-white inline-block p-5 text-white font-bold"
          >
            社内でプロフィールを公開しよう！
          </div>
          <v-row class="py-10" justify="center">
            <v-col cols="12" sm="3" align-self="start">
              <v-card outlined class="p-5" max-height="470px">
                <div
                  class="text-xl text-brown-300 font-bold border-t-4 border-b-4 border-brown-300 w-1/3 mb-5"
                >
                  01
                </div>
                <div class="text-4xl text-brown-300 font-bold">
                  書き込む
                </div>
                <img
                  src="../../images/undraw_Notebook_re_id0r.svg"
                  class="image"
                />
                <div class="text-xl text-brown-300 p-8">
                  あなたに関する様々な情報をプロフィールに書き込みましょう。
                </div>
              </v-card>
            </v-col>
            <v-col cols="12" sm="3" align-self="start">
              <v-card outlined class="p-5" max-height="470px">
                <div
                  class="text-xl text-brown-300 font-bold border-t-4 border-b-4 border-brown-300 w-1/3 mb-5"
                >
                  02
                </div>
                <div class="text-4xl text-brown-300 font-bold">
                  見る、保存する
                </div>
                <img
                  src="../../images/undraw_Taking_notes_re_bnaf.svg"
                  class="image"
                />
                <div class="text-xl text-brown-300 p-8">
                  他の社員さんのプロフィールを見てみましょう。気に入ったものはブックマークで保存できます。
                </div>
              </v-card>
            </v-col>
            <v-col cols="12" sm="3" align-self="start">
              <v-card outlined class="p-5" max-height="470px">
                <div
                  class="text-xl text-brown-300 font-bold border-t-4 border-b-4 border-brown-300 w-1/3 mb-5"
                >
                  03
                </div>
                <div class="text-4xl text-brown-300 font-bold">
                  話す
                </div>
                <img
                  src="../../images/undraw_video_call_kxyp.svg"
                  class="image"
                />
                <div class="text-xl text-brown-300 p-8">
                  あなたが知ったこと、共通の話題を社員さんと話してみましょう。
                </div>
              </v-card>
            </v-col>
          </v-row>
        </v-card>
      </v-col>
      <!-- /説明欄1 -->

      <!-- ブロック説明欄 -->
      <v-col cols="12" sm="12" align="left">
        <v-card height="700px" color="brown lighten-2" outlined align="center">
          <div class="m-10">
            <div class="text-4xl p-5 text-white font-bold">
              ブロックを使い分けて項目を入力しよう！
            </div>
            <div class="text-2xl text-white my-5">
              全5種類のブロックを使用してあなたのことを紹介してみてください。<br />
              カラフルなブロックでプロフィールを埋めてあなたのプロフィールを充実させよう！
            </div>
            <v-row
              class="py-10 border-2 border-white border-dashed"
              justify="center"
            >
              <v-col cols="10" sm="2" align="left" align-self="start">
                <div class="text-white">
                  <div
                    class="text-xl text-center font-bold border-l-4 border-r-4 border-white mb-5"
                  >
                    Favorite ブロック
                  </div>

                  <v-card
                    class="rounded-2xl p-5"
                    outlined
                    color="brown lighten-3"
                  >
                    <label class="form-label">
                      {{ favoriteBlock.title }}
                    </label>
                    <v-card
                      class="p-3 rounded-lg text-center"
                      outlined
                      color="white"
                      max-height="50px"
                    >
                      {{ favoriteBlock.text }}
                    </v-card>
                  </v-card>
                  <div class="text-lg text-center">
                    趣味や好きなものを書き込む
                  </div>
                </div>
              </v-col>
              <v-col cols="10" sm="2" align="left" align-self="start">
                <div class="text-white">
                  <div
                    class="text-xl text-center font-bold border-l-4 border-r-4 border-white mb-5"
                  >
                    クエスチョンブロック
                  </div>
                  <v-card
                    class="rounded-2xl p-5"
                    outlined
                    color="red lighten-4"
                  >
                    <template
                      v-for="question_item in questionBlock.question_items"
                    >
                      <div :key="question_item.id">
                        <div class="rounded-lg">
                          <v-row>
                            <label
                              for="question_item_content"
                              class="mx-5 text-sm"
                            >
                              {{ question_item.content }}
                            </label>
                            <v-col cols="12" sm="12" class="mb-2">
                              <v-card
                                class="p-2 text-center"
                                outlined
                                color="white"
                              >
                                {{ question_item.answer }}
                              </v-card>
                            </v-col>
                          </v-row>
                        </div>
                      </div>
                    </template>
                  </v-card>
                  <div class="text-lg text-center">
                    質問とそれに対する回答を書き込む
                  </div>
                </div>
              </v-col>
              <v-col cols="10" sm="2" align="left" align-self="start">
                <div class="text-white">
                  <div
                    class="text-xl text-center font-bold border-l-4 border-r-4 border-white mb-5"
                  >
                    ランキングブロック
                  </div>

                  <v-card
                    class="rounded-2xl p-5 note-box"
                    outlined
                    color="light-green lighten-5"
                  >
                    <v-card class="p-2 m-3 rounded-full" outlined color="white">
                      <label for="1st place" class="ranking-label">1st</label>
                      鬼滅の刃
                    </v-card>
                    <v-card class="p-2 m-3 rounded-full" outlined color="white">
                      <label for="2nd place" class="ranking-label">2nd</label>
                      呪術廻戦
                    </v-card>
                    <v-card class="p-2 m-3 rounded-full" outlined color="white">
                      <label for="3rd place" class="ranking-label">3rd</label>
                      ONE PIECE
                    </v-card>
                  </v-card>
                  <div class="text-lg text-center">
                    順位付けを書き込む
                  </div>
                </div>
              </v-col>
              <v-col cols="10" sm="2" align="left" align-self="start">
                <div class="text-white">
                  <div
                    class="text-xl text-center font-bold border-l-4 border-r-4 border-white mb-5"
                  >
                    Yes or No ブロック
                  </div>

                  <v-card
                    class="rounded-2xl p-5 note-box"
                    outlined
                    color="orange lighten-4"
                  >
                    <template
                      v-for="yes_or_no_item in yesOrNoBlock.yes_or_no_items"
                    >
                      <div :key="yes_or_no_item.id">
                        <v-card class="p-2 m-2" outlined color="white">
                          <v-row>
                            <v-col cols="12" sm="12">
                              {{ yes_or_no_item.content }}
                            </v-col>
                            <v-col
                              v-if="yes_or_no_item.answer"
                              cols="12"
                              sm="12"
                              align="center"
                            >
                              <span
                                class="rounded-full border-red-500 border-2 p-2"
                                >YES</span
                              >
                              / NO
                            </v-col>
                            <v-col v-else cols="12" sm="5">
                              YES /
                              <span
                                class="rounded-full border-red-500 border-2 p-2"
                                >NO</span
                              >
                            </v-col>
                          </v-row>
                        </v-card>
                      </div>
                    </template>
                  </v-card>
                  <div class="text-lg text-center">
                    質問に対しYes か No で書き込む
                  </div>
                </div>
              </v-col>
              <v-col cols="10" sm="2" align="left" align-self="start">
                <div class="text-white">
                  <div
                    class="text-xl text-center font-bold border-l-4 border-r-4 border-white mb-5"
                  >
                    テキストブロック
                  </div>

                  <v-card
                    class="rounded-2xl p-5 note-box"
                    outlined
                    color="teal accent-1"
                  >
                    <p class="text-2xl font-bold text-gray-600 px-3 pt-3">
                      自己紹介
                    </p>
                    <v-card class="p-3 rounded-lg" outlined color="white">
                      私はロボフスキーハムスターだよ
                    </v-card>
                  </v-card>
                  <div class="text-lg text-center">
                    自己紹介等の長文を書き込む
                  </div>
                </div>
              </v-col>
            </v-row>
          </div>
        </v-card>
      </v-col>
      <!-- ブロック説明欄 -->

      <!-- キャラクター紹介 -->
      <v-col
        cols="12"
        sm="8"
        class="border-t-2 border-b-2 border-brown-600 border-dotted my-10"
      >
        <div class="text-3xl">
          キャラクターについて
        </div>
      </v-col>
      <v-col cols="12" sm="5" align="center">
        <div class="p-10">
          <v-card
            color="brown lighten-3"
            class="text-2xl white--text rounded-full p-5"
          >
            <div class="text-4xl font-bold colorful-dot">
              CHARACTER PROFILE
            </div>
            <div class="border-2 border-dotted border-white p-5">
              ロボフスキハムスターのキャラクター。<br />
              自分のことを紹介するのが大好きでいつもプロフィール手帳を持ち歩いている。<br />
              プロフが充実しているほど機嫌が良くなる。<br />
              三度の飯より自己紹介が大好き。<br />
            </div>
            <div class="font-bold colorful-dot"></div>
          </v-card>
        </div>
      </v-col>
      <v-col cols="12" sm="5" align="left">
        <div class="balloon1">
          このサイトを楽しむためにお手伝いします！
        </div>
        <div>
          <img src="../../images/prof_normal.png" class="max-w-sm" />
        </div>
      </v-col>
    </v-row>
  </div>
</template>

<script>
export default {
  data() {
    return {
      favoriteBlock: { id: 1, title: "音楽", text: "星野源" },
      questionBlock: {
        id: 1,
        question_items: [
          {
            answer: "海外旅行",
            content: "コロナが終息したら何をする？",
          },
        ],
      },
      yesOrNoBlock: {
        id: 1,
        yes_or_no_items: [
          {
            id: 1,
            answer: true,
            content: "どちらかと言えば他人に合わせるタイプだ",
          },
        ],
      },
      rankingBlock: {},
      textBlock: {},
    };
  },
};
</script>

<style scoped>
.balloon1 {
  position: relative;
  display: inline-block;
  margin: 1.5em 0;
  padding: 1rem;
  min-width: 120px;
  max-width: 100%;
  color: #555;
  font-size: 1rem;
  background: #e0edff;
  border-radius: 15px;
}

.balloon1:before {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -15px;
  border: 15px solid transparent;
  border-top: 15px solid #e0edff;
}

.balloon1 p {
  margin: 0;
  padding: 0;
}

.colorful-dot {
  color: #ffffff; /* 文字色 */
  overflow: hidden;
  padding: 10px; /* 余白 */
  position: relative;
}
.colorful-dot:after {
  background-color: #f3a3a8; /* 1個目（一番左）のドットの色 */
  border-radius: 50%;
  content: "";
  margin-left: 15px; /* 最後の文字とドットとの余白 */
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 5px; /* ドットの幅 */
  height: 5px; /* ドットの高さ */
  box-shadow: 20px 0px 0px rgb(217, 204, 179),
    /* 2個目のドットの位置と色 */ 40px 0px 0px rgb(217, 204, 179),
    /* 3個目のドットの位置と色 */ 60px 0px 0px rgb(243, 163, 168),
    /* 4個目のドットの位置と色 */ 80px 0px 0px rgb(217, 204, 179),
    /* 5個目のドットの位置と色 */ 100px 0px 0px rgb(217, 204, 179),
    /* 6個目のドットの位置と色 */ 120px 0px 0px rgb(243, 163, 168),
    /* 7個目のドットの位置と色 */ 140px 0px 0px rgb(217, 204, 179),
    /* 8個目のドットの位置と色 */ 160px 0px 0px rgb(217, 204, 179),
    /* 9個目のドットの位置と色 */ 180px 0px 0px rgb(243, 163, 168),
    /* 10個目のドットの位置と色 */ 200px 0px 0px rgb(217, 204, 179),
    /* 11個目のドットの位置と色 */ 220px 0px 0px rgb(217, 204, 179); /* 12個目のドットの位置と色 */
}

.image {
  width: 200px;
  height: 200px;
  object-fit: contain;
  border: brown dotted 1px;
}
</style>
