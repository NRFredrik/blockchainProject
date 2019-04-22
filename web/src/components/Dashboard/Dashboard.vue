<template>
    <div id="dashboard-container">
        <div id="dashboard-sidebar">
            <div id="sidebar-title" />
            <SidebarButton :icon="'mdi-view-dashboard'" :active="true" :label="'Dashboard'" />
            <SidebarButton :icon="'mdi-content-copy'" :active="false" :label="'My Content'" />
        </div>
        <div id="dashboard-body">
            <div id="dashboard-header">

            </div>
            <div id="dashboard-subheader">
                <h3>Dashboard</h3>
            </div>
            <div class="dashboard-widget">
                <div style="display: flex;flex-direction: row;">
                    <div style="display: flex;justify-content: center;flex-direction: column;">
                        <img style="height: 60px; width: 60px" src="../../assets/eth.png" />
                    </div>
                    <div>
                        <h2 style="font-size: 36px;">ETH</h2>
                        <p style="font-size: 26px;">{{ this.balance }}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import web3 from '../../api/web3'
import SidebarButton from './SidebarButton'

export default {
    mounted: async function() { 
        this.balance = (await web3.eth.getBalance('0xf462F83F0E652ab0A6378e6b15De29bfaE11fa19') / 1000000000000000000).toFixed(3)
    },
    data: () => {
        return {
            balance: 0
        }
    },
    components: {
        SidebarButton
    }
}
</script>

<style scoped>
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