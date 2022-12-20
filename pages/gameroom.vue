<template>
  <v-container>
    <roller-input ref="roller" @roll="handleRoll" />

    <die-roll-log :rolls="log" @roll="reroll" />
  </v-container>
</template>

<script>
import { mapState } from 'vuex'
import { parseRoll } from '~/lib/roller.js'

export default {
  head: () => ({
    title: 'Game Room',
  }),

  data: () => ({
    socket: null,
    log: [],
  }),

  computed: {
    currentRoll() {
      return parseRoll(this.rollInput)
    },

    errors() {
      return this.rollInput
    },

    ...mapState(['iam']),
  },

  methods: {
    handleRoll(roll) {
      const rollEvent = {
        player: this.iam ? this.iam.name : 'Fate',
        input: roll.input,
        result: roll.result,
      }

      console.log(rollEvent)

      this.socket.emit('roll', rollEvent)
    },

    reroll(roll) {
      if (this.$refs.roller) {
        this.$refs.roller.rollFav(roll.input)
      }
    },

    logRoll(roll) {
      this.log.unshift(roll)
    },
  },

  mounted() {
    this.socket = this.$nuxtSocket({
      channel: '/gameroom',
    })

    this.socket.on('roll', (roll) => {
      this.logRoll(roll)
    })
  },
}
</script>
