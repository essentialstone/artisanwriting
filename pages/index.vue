<template>
  <v-container>
    <v-expansion-panels class="mb-3" hover>
      <v-expansion-panel>
        <v-expansion-panel-header disable-icon-rotate>
          Tag Details

          <template #actions>
            <v-icon> mdi-information-outline </v-icon>
          </template>
        </v-expansion-panel-header>

        <v-expansion-panel-content>
          <v-list-item v-for="tag in sortedTags" :key="tag.id" two-line>
            <v-list-item-content>
              <v-list-item-title>{{ tag.name }}</v-list-item-title>
              <v-list-item-content>{{
                tag.description || 'Sorry, Jake needs to add a description for this tag.'
              }}</v-list-item-content>
            </v-list-item-content>
          </v-list-item>
        </v-expansion-panel-content>
      </v-expansion-panel>
    </v-expansion-panels>

    <v-card v-for="sentence in sentences" :key="sentence.id" class="mb-3" outlined>
      <v-container>
        <v-card-title> {{ sentence.source_name }} </v-card-title>

        <v-card-text>
          <p>
            {{ sentence.words }}
          </p>

          <v-chip-group v-model="sentence.tags" multiple column>
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
      <v-btn v-if="validRater" outlined rounded text x-large class="mt-6" @click="submit">
        Next
      </v-btn>
    </v-row>
  </v-container>
</template>

<script>
import { mapState } from 'vuex'
export default {
  data: () => ({
    sentences: [],
    tags: [],
    raters: [],
    sources: [],
    stats: {},
  }),

  computed: {
    validRater() {
      return this.iam && this.iam.id !== null
    },

    sortedTags() {
      return this.tags.sort((a, b) => a.id - b.id)
    },

    ...mapState(['iam']),
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
        this.$http.post(`/api/raters/${this.iam.id}/ratings`, ratings)
      }

      this.fetchSentences()
    },

    tagIndexToId(indexes) {
      return indexes
        .map((index) => this.tags[index])
        .filter((it) => it)
        .map((it) => it.id)
    },

    async fetchSentences() {
      if (this.iam) {
        this.sentences = await this.$http.$get(`/api/sentences`)
      }
    },
  },

  watch: {
    iam(iam) {
      if (this.validRater) {
        this.fetchSentences()
      } else {
        this.sentences = []
      }
    },
  },

  async mounted() {
    this.tags = await this.$http.$get('/api/tags')
    this.sources = await this.$http.$get('/api/sources')

    if (this.validRater) {
      this.fetchSentences()
    }
  },
}
</script>
