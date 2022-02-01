<template>
  <v-app>
    <v-app-bar app dense>
      <v-toolbar-title>Essential Stone</v-toolbar-title>

      <template #extension>
        <v-tabs>
          <v-tab to="/">Artisan Writing</v-tab>
          <!-- <v-tab to="/stats">Stats</v-tab> -->
        </v-tabs>
      </template>
    </v-app-bar>

    <v-main>
      <v-container>
        <Nuxt />
      </v-container>
    </v-main>
  </v-app>
</template>
