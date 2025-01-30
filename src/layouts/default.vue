<template>
  <AppHeader />

  <v-main>
    <router-view v-slot="{ Component }">
      <Transition class="fill-height" name="slide-up" mode="out-in">
        <component :is="Component" />
      </Transition>
    </router-view>
  </v-main>

  <AppFooter />
</template>

<script lang="ts" setup>
import router from '@/router';
import { routes } from 'vue-router/auto-routes'
import { ref, onMounted, onUnmounted } from 'vue';

let routeIndex = 0;
const routeArray = routes.map(({ path }) => path);
const scrollDirection = ref('');

// Detect mouse wheel movement
const handleWheel = async (event: WheelEvent) => {
  if (event.deltaY > 0) {
    scrollDirection.value = 'down';
    routeIndex++;
    if (routeIndex > 3) {
      routeIndex = 0;
    }
    await router.push(routeArray[routeIndex]);
  } else if (event.deltaY < 0) {
    scrollDirection.value = 'up';
    routeIndex--;
    if (routeIndex < 0) {
      routeIndex = 3;
    }
    await router.push(routeArray[routeIndex]);
  }
};

onMounted(() => {
  window.addEventListener('wheel', handleWheel);
});

onUnmounted(() => {
  window.removeEventListener('wheel', handleWheel);
});
</script>

<style scoped>
/* Smooth slide-up transition */
.slide-up-enter-active,
.slide-up-leave-active {
  transition: opacity 0.5s ease-out, transform 0.5s ease-out;
}

.slide-up-enter-from {
  opacity: 0;
  transform: translateY(400px);
}

.slide-up-leave-to {
  opacity: 0;
  transform: translateY(-400px);
}
</style>
