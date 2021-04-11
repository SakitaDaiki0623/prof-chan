<template>
  <v-app-bar color="gray accent-4" dark>
    <v-app-bar-nav-icon></v-app-bar-nav-icon>

    <v-toolbar-title>プロフちゃん</v-toolbar-title>

    <div class="flex-grow-1"></div>
    <a href="/logout">ログアウト</a>

    <v-btn icon>
      <v-icon>mdi-magnify</v-icon>
    </v-btn>

    <v-menu left bottom>
      <template v-slot:activator="{ on }">
        <v-btn icon v-on="on">
          <v-icon>mdi-dots-vertical</v-icon>
        </v-btn>
      </template>

      <v-list>
        <v-list-item v-for="n in 5" :key="n" @click="() => {}">
          <v-list-item-title>りんく {{ n }}</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>
  </v-app-bar>
</template>


