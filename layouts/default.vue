<template>
  <v-app>
    <v-app-bar app dense>
      <v-toolbar-title>Artisan Writing</v-toolbar-title>

      <!-- <template #extension>
        <v-tabs>
          <v-tab to="/">Rate</v-tab>
          <v-tab to="/stats">Stats</v-tab>
        </v-tabs>
      </template> -->
    </v-app-bar>

    <v-main>
      <v-row justify="center" align="center">
        <v-col cols="12" sm="8" md="6">
          <v-container>
            <Nuxt />
          </v-container>
        </v-col>
      </v-row>
    </v-main>
  </v-app>
</template>
