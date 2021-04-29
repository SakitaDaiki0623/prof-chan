<template>
  <v-container>
    <div class="flex-grow">
      <div class="bg-indigo-100 pl-40 pt-32">
        <div class="text-left">
          <p class="tracking-widest">あなたと社員をより近く</p>
          <h1 class="text-8xl mt-6">プロフちゃん</h1>
          <p class="mt-6">
            Withコロナ時代のフルリモート社員に贈る社員プロフィール公開サービス
          </p>
          <div class="mt-20 inline-block">
            <a
              class="slack-btn"
              rel="nofollow"
              data-method="post"
              href="/users/auth/slack"
              >Slackログイン</a
            >
          </div>
        </div>
        <img
          class="absolute right-20 top-20 w-1/5 mr-48"
          src="/assets/top_bg-24da2a66a3159c064d5d9ff428bd39ef4db1d89df5bcf0b8ff92a33f6061ccda.jpg"
        />
      </div>
    </div>
    <div class="antialiased bg-indigo-100 shadow-md">
      <div
        class="container mx-auto py-4 px-5 flex flex-wrap flex-col sm:flex-row"
      >
        <p class="text-gray-500 text-sm text-center font-light sm:text-left">
          © 2021 プロフちゃん<a class="ml-3" href="#">利用規約</a
          ><a class="ml-3" href="#">プロフちゃんとは</a>
        </p>
      </div>
    </div>
  </v-container>
</template>

<script>
export default {};
</script>

<style scoped>
</style>