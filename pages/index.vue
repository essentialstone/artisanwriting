<template>
  <div>
    <v-autocomplete
      label="Who are you?"
      v-model="iam"
      :items="raters"
      item-value="id"
      item-text="name"
      rounded
      solo
    />

    <v-card v-for="sentence in sentences" :key="sentence.id" class="mb-3" outlined>
      <v-container>
        <v-card-title> {{ sourceName(sentence) }} </v-card-title>

        <v-card-text>
          <p>
            {{ sentence.words }}
          </p>

          <v-chip-group v-model="sentence.tagIndex">
            <v-chip v-for="tag in tags" :key="tag.id" outlined filter>
              {{ tag.name }}
            </v-chip>
          </v-chip-group>

          <v-text-field
            v-if="sentence.tagIndex !== undefined"
            v-model="sentence.explanation"
            label="WHy? (Optional)"
            placeholder="Becuase I rool and you drool!"
          />
        </v-card-text>
      </v-container>
    </v-card>

    <v-row justify="end">
      <v-btn v-if="iam" outlined rounded text x-large class="mt-6" @click="submit">
        Next
      </v-btn>
    </v-row>
  </div>
</template>

<script>
export default {
  data: () => ({
    sentences: [],
    tags: [],
    raters: [],
    sources: [],
    iam: null,
    stats: {},
  }),

  computed: {
    iamName() {
      if (this.iam) {
        return (
          this.raters.filter((it) => it.id === this.iam).map((it) => it.name)[0] || ''
        )
      }
    },
  },

  methods: {
    sourceName(sentence) {
      return (
        this.sources
          .filter((it) => !!it)
          .filter((it) => it.id === sentence.sourceId)
          .map((it) => it.name)[0] || 'Unknown...'
      )
    },

    submit() {
      const ratings = this.sentences
        .filter((it) => it.tagIndex !== undefined)
        .map((it) => ({
          sentenceId: it.id,
          tagId: this.tags[it.tagIndex].id,
          explanation: it.explanation,
        }))

      if (ratings.length > 0) {
        this.$axios.post(`/api/raters/${this.iam}/ratings`, ratings)
      }

      this.fetchSentences()
    },

    async fetchSentences() {
      if (this.iam) {
        this.sentences = await this.$axios.$get(`/api/raters/${this.iam}/sentences`)
      }
    },

    async fetchRaterStats() {
      if (this.iam) {
        this.stats.raterTotal = await this.$axios.$get(`/api/raters/${this.iam}/total`)
      }
    },
  },

  watch: {
    iam(iam) {
      if (iam) {
        this.fetchRaterStats()
        this.fetchSentences()
      }
    },
  },

  async mounted() {
    this.tags = await this.$axios.$get('/api/tags')
    this.raters = await this.$axios.$get('/api/raters')
    this.sources = await this.$axios.$get('/api/sources')
  },
}
</script>
