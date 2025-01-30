<template>
    <v-card 
      rounded 
      elevation="4" 
      class="mt-16 pa-4"
    >
        <h2 class="content-with-border">{{ title }}</h2>
    </v-card>    
</template>
  
  
<script lang="ts" setup>

    defineProps({
        title: String,
        icon: {type: String, required: false},
    })

</script>


<style scoped>
.content-with-border {
  border-left: 10px solid white; /* Thick left border */
  padding-left: 16px; /* Space between border and content */
}
</style>