<template>
  <v-data-table :headers="headers" :items="rolls" single-expand>
    <template #item.result="{ item }">
      {{ getValues(item).join(', ') }}
    </template>

    <!-- <template #item.summary="{ item }">
      {{ summary(item) }}
    </template> -->

    <template #item.total="{ item }">
      {{ total(item) }}
    </template>

    <template #item.reroll="{ item }">
      <v-btn icon @click="$emit('roll', item)">
        <v-icon dark> mdi-dice-multiple </v-icon>
      </v-btn>
    </template>
  </v-data-table>
</template>

<script>
export default {
  props: {
    rolls: { type: Array, default: () => [] },
  },

  data: () => ({
    headers: [
      { text: 'Player', value: 'player' },
      { text: 'Roll', value: 'input' },
      { text: 'Results', value: 'result' },
    //   { text: 'Summary', value: 'summary' },
      { text: 'Total', value: 'total' },
      { text: '', value: 'reroll', sortable: false, width: '3rem', align: 'end' },
    ],
  }),

  methods: {
    getValues(roll) {
      return roll.result.map((it) => it.value).sort((a, b) => b - a)
    },

    summary(roll) {
      const counts = this.getValues(roll).reduce((dict, value) => {
        if (!dict[value]) {
          dict[value] = 1
        } else {
          dict[value] += 1
        }

        return dict
      }, {})

      return Object.entries(counts)
        .sort((a, b) => b[0] - a[0])
        .map(([value, count]) => `"${value}": ${count}`)
        .join(', ')
    },

    total(roll) {
      return this.getValues(roll).reduce((a, b) => a + b, 0)
    },
  },
}
</script>
