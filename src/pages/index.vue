<template>
  <v-container class="fill-height">
    <v-responsive
      class="align-centerfill-height mx-auto"
      max-width="900"
    >
      <div class="d-flex justify-center align-center">
        <img
          class="mb-4"
          style="border-radius: 50% !important;"
          width="225"
          height="225"
          src="@/assets/matt.jpeg"
        />
      </div>
      <div class="text-center">
        <div class="text-body-3 font-weight-light mb-n1">Hi, I'm</div>
        <h1 class="text-h3 font-weight-bold">Matt Leslie</h1>
      </div>
      <div class="py-4" />

      <div>
        <p>
          I'm a full stack software engineer building hydrology and climate related web applications. Right now, I support the USGS Web Informatics Team.
          I'm excited to serve the American public and do my part to bring the Federal Government into the modern digital age. Please reach out! I'd love to chat about climate tech, renewable energy, maps, trail running, morel foraging, or anything that excites you.
        </p>
      </div>

      <hr class="my-4" style="height:4px;border:none;color:white;background-color:white;">


      <v-row no-gutters>
        <v-col
          v-for="item in tabs"
          :key="item.title"
          cols="12"
          sm="4"
        >
          <v-card 
            elevation="4"
            class="ma-2 py-6 d-flex align-center justify-center"
            :to="item.href"
          >
            <div class="d-flex align-center ga-2">
              <v-icon :icon="item.icon" class="text-h4"></v-icon>
              <span class="text-h6 font-weight-bold">{{ item.title }}</span>
            </div>
          </v-card>
        </v-col>
      </v-row>
      <div class="d-flex justify-center ga-8 mt-2">
        <v-card 
          v-for="item in links"
          :key="item.href"
          height="92"
          rounded="circle"
          width="92"
          elevation="4"
          class="ma-2 py-6 d-flex align-center justify-center"
          :href="item.href"
          rel="noopener"
          target="_blank"
          >
          <div class="d-flex align-center">
            <v-img v-if="item.img" :src="item.img" width="42" height="42"></v-img>
            <v-icon v-else :icon="item.icon" size="42"></v-icon>
          </div>
        </v-card>
      </div>
    </v-responsive>
  </v-container>
</template>

<script setup lang="ts">
  import stravaLogo from '@/assets/strava.svg'

  const tabs = [
    {
      title: 'About',
      icon: `mdi-information`,
      href: '/about'
    },
    {
      title: 'Projects',
      icon: `mdi-folder-outline`,
      href: '/projects'
    },
    {
      title: 'Blog',
      icon: `mdi-book-open-variant`,
      href: '/blog'
    },
  ]
  const links = [
    {
      icon: `mdi-linkedin`,
      href: 'https://www.linkedin.com/in/matt-leslie-59306a203/',
      img: '',
    },
    {
      icon: `mdi-github`,
      href: 'https://github.com/mattLeslie',
      img: '',
    },
    {
      icon: ``,
      href: 'https://www.strava.com/athletes/31637440',
      img: stravaLogo
    },
    {
      icon: `mdi-email`,
      href: 'mailto:matt.leslie.dev@gmail.com',
      img: '',
    },

  ]
</script>
