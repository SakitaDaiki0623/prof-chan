<template>
  <div>
    <div class="top-bg">
      <div class="border-t-2 border-brown-500 border-dashed">
        <v-row justify="center" align-content="center">
          <v-col cols="12" sm="12">
            <div class="text-center text-lg md:text-2xl lg:text-4xl">
              - - - - REMOTELY PROMOTE YOURSELF.- - - -
            </div>
          </v-col>
          <v-col cols="12" sm="12" md="7" align-self="center" align="right">
            <img
              src="../../../assets/images/logo.png"
              class="max-w-md md:max-w-xl mx-auto"
            />
          </v-col>
          <v-col cols="12" sm="4" md="5" align="left">
            <div class="balloon1 text-sm text-center md:text-2xl">
              slackログイン版
            </div>
            <img
              src="../../images/prof_happy.png"
              class="max-w-xs md:max-w-sm"
            />
          </v-col>
        </v-row>
      </div>
    </div>
    <div class="bg-brown-500 pa-10">
      <v-row justify="center" align-content="center">
        <v-col cols="12" sm="4" class="border-white border-dotted border-2">
          <div>
            <div class="text-white text-2xl text-center">
              こちらは{{ team.name }}の本サイトのワークスペースです。<br />
              {{
                team.name
              }}のワークスペース内の人とのみプロフを共有します。<br />
            </div>
          </div>
        </v-col>
        <v-col cols="4" align="center">
          <v-img
            :src="team.image"
            max-width="10rem"
            class="border-8 border-white shadow-md"
          ></v-img>
        </v-col>
      </v-row>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";

export default {
  data() {
    return {
      team: {},
    };
  },
  mounted() {
    this.firstRead();
  },
  computed: {
    ...mapState("users", ["currentUser"]),
  },
  methods: {
    async firstRead() {
      await this.fetchTeam();
    },
    async fetchTeam() {
      await axios
        .get(`/api/v1/teams/${this.currentUser.workspace_id}`)
        .then((res) => (this.team = res.data));
    },
  },
};
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
  min-width: 220px;
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
