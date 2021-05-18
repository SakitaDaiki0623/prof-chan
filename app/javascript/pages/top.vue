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
              <div class="text-8xl p-10 font-body">
                プロフちゃん
              </div>
            </div>
          </v-col>
          <v-col cols="12" sm="4">
            <img src="../images/prof_glad.png" class="h-80" />
          </v-col>
        </v-row>
      </div>
    </div>
    <div class="p-20 text-center">
      <v-row class="px-20" justify="center" align-content="center">
        <v-col cols="12" sm="12">
          <div class="text-3xl top-sub-title mb-10">
            最近入社した社員さん
          </div>
        </v-col>
        <transition-group tag="v-row">
          <v-col
            v-for="recentlyJoinedUserProfile in recentlyJoinedUserProfiles"
            :key="recentlyJoinedUserProfile.public_uid"
            cols="4"
          >
            <v-card
              class="mx-auto"
              max-width="344"
              outlined
              color="brown lighten-5"
            >
              <v-card color="brown lighten-2" class="white--text">
                {{ recentlyJoinedUserProfile.day_of_joinning }} 入社
              </v-card>
              <v-img
                :src="recentlyJoinedUserProfile.user.image.url"
                height="180px"
              />

              <div class="text-center font-bold text-3xl pt-5 text-brown-600">
                {{ recentlyJoinedUserProfile.user.name }} さん
              </div>

              <v-card-actions>
                <v-spacer />
                <v-btn
                  color="brown lighten-1"
                  class="white--text"
                  small
                  tile
                  @click="moveToUserProfilePage(recentlyJoinedUserProfile)"
                >
                  社員プロフィールを見る
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-col>
        </transition-group>
        <v-col cols="12" sm="12">
          <div class="text-3xl top-sub-title mb-10">
            今月誕生日の人
          </div>
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
import axios from "axios";
import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      recentlyJoinedUserProfiles: [],
      show: false,
    };
  },
  mounted() {
    this.firstRead();
  },
  methods: {
    ...mapActions({
      fetchCurrentUser: "users/fetchCurrentUser",
      fetchTextBlocks: "textBlocks/fetchTextBlocks",
      fetchRankingBlocks: "rankingBlocks/fetchRankingBlocks",
      fetchYesOrNoBlocks: "yesOrNoBlocks/fetchYesOrNoBlocks",
      fetchYesOrNoItems: "yesOrNoBlocks/fetchYesOrNoItems",
      fetchQuestionBlocks: "questionBlocks/fetchQuestionBlocks",
      fetchQuestionItems: "questionBlocks/fetchQuestionItems",
      fetchUsers: "users/fetchUsers",
    }),
    async firstRead() {
      await this.fetchRecentlyJoinedUserProfiles();
      await this.fetchCurrentUser();
      await this.fetchUsers();
      await this.fetchTextBlocks();
      await this.fetchRankingBlocks();
      await this.fetchYesOrNoBlocks();
      await this.fetchYesOrNoItems();
      await this.fetchQuestionBlocks();
      await this.fetchQuestionItems();
    },
    async fetchRecentlyJoinedUserProfiles() {
      await axios
        .get("/api/v1/profiles/recently_joined_user_profiles")
        .then((res) => (this.recentlyJoinedUserProfiles = res.data));
    },
    moveToUserProfilePage(profile) {
      this.$router.push(`/profiles/${profile.public_uid}`);
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
  height: 560px;
  padding: 2rem;
}
</style>
