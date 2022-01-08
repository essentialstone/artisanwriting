<template>
  <v-simple-table>
    <tbody>
      <tr v-for="rater in raters" :key="rater.id">
        <td>{{ rater.id }}</td>
        <td>{{ rater.name }}</td>
      </tr>
    </tbody>
  </v-simple-table>
</template>

<script>
export default {
  data: () => ({
    raters: [],
  }),

  async mounted() {
    this.raters = await this.$axios.$get('/api/raters')
  },
}
</script>
