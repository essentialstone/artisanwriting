<template>
  <v-app>
    <v-app-bar app dense>
      <v-toolbar-title>Essential Stone</v-toolbar-title>

      <v-spacer />

      <profile-chooser />

      <template #extension>
        <v-tabs>
          <v-tab to="/">Artisan Writing</v-tab>
          <v-tab to="/gameroom">Game Room</v-tab>
          <!-- <v-tab to="/stats">Stats</v-tab> -->
        </v-tabs>
      </template>
    </v-app-bar>

    <v-main>
      <v-container>
        <Nuxt keep-alive />
      </v-container>
    </v-main>
  </v-app>
</template>
