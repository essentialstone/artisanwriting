<template>
  <form @submit.prevent="roll">
    <v-text-field
      v-model="input"
      placeholder="5d10..."
      @click:clear="reset()"
      :error-messages="errors"
      solo
      clearable
    >
      <template #append>
        <v-tooltip bottom>
          <template #activator="{ on, attrs }">
            <v-btn type="submit" v-bind="attrs" v-on="on" icon>
              <v-icon dark> mdi-dice-multiple </v-icon>
            </v-btn>
          </template>
          <span> Roll! </span>
        </v-tooltip>
      </template>
    </v-text-field>
  </form>
</template>

<script>
import { parseRoll } from '~/lib/roller.js'

export default {
  data: () => ({
    input: '',
    errors: null,
  }),

  computed: {
    currentRoll() {
      return parseRoll(this.input)
    },
  },

  methods: {
    reset() {
      this.input = ''
      this.errors = null
    },

    roll() {
      if (this.currentRoll.isAccepted()) {
        this.$emit('roll', {
          input: this.input,
          result: this.currentRoll.value,
        })
        this.reset()
      } else {
        this.errors = 'Syntax Error'
      }
    },

    rollFav(roll) {
      this.input = roll
      this.roll()
    },
  },
}
</script>
