<template>
  <div class="mt-9">
    <v-autocomplete
      label="Who are you?"
      :value="iam"
      :items="users"
      item-value="id"
      item-text="name"
      rounded
      solo
      dense
      @change="setIam"
    />
  </div>
</template>

<script>
import { mapMutations, mapState } from 'vuex'

export default {
  data: () => ({
    users: [],
  }),

  computed: {
    ...mapState(['iam']),
  },

  methods: {
    setIam(id) {
      const iam = this.users.filter((it) => it.id === id)[0]
      this.updateIam(iam)
    },

    ...mapMutations(['updateIam']),
  },

  async mounted() {
    this.users = await this.$http.$get('/api/raters')
    this.users.push({
        id: null,
        name: "Fate"
    })
  },
}
</script>
