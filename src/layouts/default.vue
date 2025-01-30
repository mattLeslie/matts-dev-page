<template>
  <AppHeader :routeArray="routeArray"/>

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
import { ref, onMounted, onUnmounted } from 'vue';

let routeIndex = 0;

const routeArray = [
  ['Landing', '/'],
  ['About', '/about'],
  ['Projects', '/projects'],
  ['Blog', '/blog'],
]

const scrollDirection = ref('');
let scrollTimeout: ReturnType<typeof setTimeout> | null = null;

// Detect mouse wheel movement
const handleWheel = async (event: WheelEvent) => {

  if (scrollTimeout) return; // Prevent execution while waiting

  scrollTimeout = setTimeout(() => {
    scrollTimeout = null; // Reset timeout to allow future scrolls
  }, 150); // Adjust delay to match transition time

  if (event.deltaY > 0) {
    scrollDirection.value = 'down';
    routeIndex++;
    if (routeIndex > 3) {
      routeIndex = 0;
    }
    await router.push(routeArray[routeIndex][1]);
  } else if (event.deltaY < 0) {
    scrollDirection.value = 'up';
    routeIndex--;
    if (routeIndex < 0) {
      routeIndex = 3;
    }
    await router.push(routeArray[routeIndex][1]);
  }
};


const handleKeyPress = async (event: KeyboardEvent) => {
  if (event.key === 'ArrowDown'){
    routeIndex++;
    if (routeIndex > 3) {
      routeIndex = 0;
    }
    await router.push(routeArray[routeIndex][1]);
  }
  else if (event.key === 'ArrowUp'){
    routeIndex--;
    if (routeIndex < 0) {
      routeIndex = 3;
    }
    await router.push(routeArray[routeIndex][1]);
  }
};

onMounted(() => {
  window.addEventListener("wheel", handleWheel, { passive: false });
  window.addEventListener('keydown', handleKeyPress); // Listen for keyboard events
  // Prevent scrolling when switching pages
  document.body.style.overflow = "hidden";
  document.documentElement.style.overflow = "hidden"; // Ensure no scrolling at all
});

onUnmounted(() => {
  window.removeEventListener('wheel', handleWheel);
});
</script>

<style scoped>
/* Faster and smoother page transition */
.slide-up-enter-active,
.slide-up-leave-active {
  transition: opacity 0.4s ease-out, transform 0.5s ease-in-out;
}

/* Entering component starts from bottom */
.slide-up-enter-from {
  opacity: 0;
  transform: translateY(100vh); /* Moves in from slightly below the screen */
}

/* Leaving component exits to the top */
.slide-up-leave-to {
  opacity: 0;
  transform: translateY(-100vh); /* Moves out faster but doesn't feel sluggish */
}


</style>
