<template>
    <div id="dashboard-container">
        <div id="dashboard-sidebar">
            <div id="sidebar-title" />
            <SidebarButton :to="'/Dashboard'" :icon="'mdi-view-dashboard'" :active="this.activeTab === 'Dashboard'" :label="'Dashboard'" />
            <SidebarButton :to="'/MyContent'" :icon="'mdi-content-copy'" :active="this.activeTab === 'MyContent'" :label="'My Content'" />
        </div>
        <div id="dashboard-body">
            <div id="dashboard-header">
              <input @change="updateWallet" id="wallet" :value="wallet" placeholder="Enter wallet address" />
            </div>
            <div id="dashboard-subheader">
                <h3>{{ this.activeTab }}</h3>
            </div>
            <router-view></router-view>
        </div>
    </div>
</template>

<script>
import SidebarButton from './components/SidebarButton'
import { mapGetters, mapActions } from 'vuex'

export default {
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
  h4 { text-decoration: none !important; } 
  #wallet {
    float: right;
    border: 1px solid #ddd;
    border-radius: 3px;
    margin: auto 0;
    padding: 10px;
    margin-top: 12px;
    margin-right: 20px;
    width: 360px;
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
