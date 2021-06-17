<template>
  <div class="border-2 border-dashed border-brown-500 pa-5 text-center">
    <v-menu offset-x>
      <template #activator="{ on, attrs }">
        <v-btn
          v-bind="attrs"
          color="brown lighten-3"
          class="white--text text-2xl"
          v-on="on"
          x-large
        >
          ブックマークした人
        </v-btn>
      </template>

      <v-card width="500px" max-height="500px" color="brown">
        <v-list color="brown lighten-3">
          <v-list-item v-for="user in block.users" :key="user.id">
            <v-list-item-avatar color="white">
              <v-img :src="user.image.url"></v-img>
            </v-list-item-avatar>
            <v-list-item-title class="white--text">
              {{ user.name }}
            </v-list-item-title>
          </v-list-item>
        </v-list>
      </v-card>
    </v-menu>
  </div>
</template>

<script>
export default {
  props: {
    block: {
      type: Object,
      required: true,
    },
  },
};
</script>