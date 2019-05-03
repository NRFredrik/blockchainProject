<template>
    <div v-if="wallet.length > 0" id="dashboard-container">
        <div id="dashboard-sidebar">
            <div id="sidebar-title" />
            <SidebarButton :to="'/Dashboard'" :icon="'mdi-view-dashboard'" :active="this.activeTab === 'Dashboard'" :label="'Dashboard'" />
            <SidebarButton :to="'/MyContent'" :icon="'mdi-content-copy'" :active="this.activeTab === 'MyContent'" :label="'My Content'" />
        </div>
        <div id="dashboard-body">
            <div id="dashboard-header">
              <p id="wallet"><span>Wallet Address: </span>{{ wallet }}</p>
            </div>
            <router-view></router-view>
        </div>
    </div>
</template>

<script>
import SidebarButton from './components/SidebarButton'
import web3 from './api/web3'
import { mapGetters, mapActions } from 'vuex'
import abi from './api/abi'
import axios from 'axios'

export default {
  mounted: async function() { 
    const wallet = (await web3.eth.getAccounts())[0]
    this.$store.dispatch('setWallet', wallet)
  },
  updated: function() { this.activeTab = this.$route.name },
  data: function() {
    return {
      activeTab: this.$route.name
    }
  },
  methods: {
    ...mapActions(['setWallet']),
    updateWallet(e) { this.setWallet(e.target.value) }
  },
  components: {
      SidebarButton
  },
  computed: mapGetters(['wallet'])
}
</script>

<style>
  body {
    padding: 0;
    margin: 0;
    font-family: -apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Helvetica Neue,Arial,sans-serif;
    color: #3d5170;
  }
  h1, h2, h3, h4, h5, h6, p, a { text-decoration: none !important; margin: 0; } 
  #wallet {
    float: right;
    margin: auto 0;
    padding: 10px;
    margin-top: 12px;
    margin-right: 10px;
    font-weight: 600;
  }
  #wallet span {
    font-style: italic;
    font-weight: 400;
  }
  .full-width {
    width: auto !important;
  }
  #wallet:focus {
    outline:none;
  }
  #dashboard-container {
      display: flex;
  }
  #dashboard-sidebar {
      display: flex;
      flex-direction: column;
      background-color: #fff;
      width: 250px;
      height: 100vh;
      box-shadow: 2px 2px 20px 11px #f0f2f3;
  }
  #sidebar-title {
      height: 65px;
      width: 100%;
      border-bottom: 1px solid #e1e5eb;
  }
  #dashboard-body {
      display: flex;
      flex-direction: column;
      width: 100%;
  }
  #dashboard-header {
      height: 65px;
      width: 100%;
      border-bottom: 1px solid #dddddd80;
      box-shadow: 20px 0px 20px 11px #f0f2f3;
  }
  #dashboard-subheader h3 {
      margin: 14px 0px 10px 20px;
      font-size: 26px;
      letter-spacing: .6px;
      font-weight: 400;
  }
  .dashboard-widget {
      width: 30%;
      background-color: white;
      margin: 20px;
      border-radius: 4px;
      box-shadow: 0 2px 0 rgba(90,97,105,.11), 0 4px 8px rgba(90,97,105,.12), 0 10px 10px rgba(90,97,105,.06), 0 7px 70px rgba(90,97,105,.1);
      text-align: center;
      padding: 10px;
  }
  .dashboard-widget > div {
      flex-basis: 50%;
      display: flex;
      flex-direction: column;
      justify-content: center;
  }
</style>
