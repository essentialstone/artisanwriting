<template>
  <v-card>
    <v-container>
      <v-card-text>
        {{ sentence }}
      </v-card-text>

      <v-btn class="ma-1" v-for="tag in tags" :key="tag" @click="$emit(tag)">
        {{ tag }}
      </v-btn>
    </v-container>
  </v-card>
</template>

<script>
export default {
  props: {
    sentence: { type: String, required: true },
    tags: { type: Array, default: () => [] },
  },
}
</script>
