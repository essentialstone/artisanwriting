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
        <v-card-title> {{ sentence.source_name }} </v-card-title>

        <v-card-text>
          <p>
            {{ sentence.words }}
          </p>

          <v-chip-group v-model="sentence.tags" multiple>
            <v-chip v-for="tag in tags" :key="tag.id" outlined filter>
              {{ tag.name }}
            </v-chip>
          </v-chip-group>

          <v-text-field
            v-if="sentence.tags !== undefined"
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
          .filter((it) => it.id === sentence.source_id)
          .map((it) => it.name)[0] || 'Unknown...'
      )
    },

    submit() {
      const ratings = this.sentences
        .filter((it) => it.tags)
        .filter((it) => it.tags.length > 0)
        .map((it) => ({
          sentence_id: it.id,
          source_id: it.source_id,
          explanation: it.explanation,
          tags: this.tagIndexToId(it.tags),
        }))

      if (ratings.length > 0) {
        this.$http.post(`/api/raters/${this.iam}/ratings`, ratings)
      }

      this.fetchSentences()
    },

    tagIndexToId(indexes) {
      return indexes
        .map((index) => this.tags[index])
        .filter(it => it)
        .map(it => it.id)
    },

    async fetchSentences() {
      if (this.iam) {
        this.sentences = await this.$http.$get(`/api/sentences`)
      }
    },
  },

  watch: {
    iam(iam) {
      if (iam) {
        this.fetchSentences()
      }
    },
  },

  async mounted() {
    console.log(this.$http.getBaseURL())

    this.tags = await this.$http.$get('/api/tags')
    this.raters = await this.$http.$get('/api/raters')
    this.sources = await this.$http.$get('/api/sources')
  },
}
</script>
