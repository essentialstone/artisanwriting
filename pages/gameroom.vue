<template>
  <v-container>
    <roller-input ref="roller" @roll="handleRoll" />

    <!-- <v-card rounded>
      <v-list v-if="log.length > 0">
        <v-list-item-group>
          <v-list-item v-for="(roll, i) in log" :key="i" @click="reroll(roll)">
            <v-list-item-icon>
              <v-icon dark> mdi-dice-multiple </v-icon>
            </v-list-item-icon>

            <v-list-item-content>
              {{ roll }}
            </v-list-item-content>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-card> -->

    <die-roll-log :rolls="log" @roll="reroll" />
  </v-container>
</template>

<script>
import { mapState } from 'vuex'
import { parseRoll } from '~/lib/roller.js'

export default {
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
