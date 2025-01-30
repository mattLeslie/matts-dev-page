<template>
  <div class="position-relative">
    <div class="position-absolute" style="left: 30px; top: 60px;">
      <div v-for="route in routeArray">

        <v-card 
          variant="plain" 
          :ripple="false"
          style="opacity: 100%; cursor: pointer;" 
          v-if="currentRoute.path == route[1]"
          :to="route[1]"
        >
          <v-card-text>
            <h2>
              {{ route[0] }}
            </h2>
          </v-card-text>
        </v-card>
        <v-card 
          variant="plain" 
          :ripple="false"
          style="cursor: pointer;" 
          :to="route[1]"
          v-else
        >
          <v-card-text>
            <h4>
              {{ route[0] }}
            </h4>
          </v-card-text>
        </v-card>
      </div>

    </div>
  </div>
</template>

<script setup lang="ts">

defineProps<{
  routeArray: string[][];
}>();

import { useRoute } from 'vue-router'
const currentRoute = useRoute();




</script>
