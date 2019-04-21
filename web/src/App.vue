<template>
  <router-view>
    <Dashboard />
  </router-view>
</template>

<script>
import Dashboard from './components/Dashboard/Dashboard'

export default {
  name: 'App',
  components: {
    Dashboard
  },
  data () {
    return {
      //
    }
  }
}
</script>

<style>
  body {
    padding: 0;
    margin: 0;
    font-family: -apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Helvetica Neue,Arial,sans-serif;
    color: #3d5170
  }
</style>
