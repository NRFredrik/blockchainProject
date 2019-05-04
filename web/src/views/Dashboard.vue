<template>
    <div>
        <div id="dashboard-subheader">
            <h3>Dashboard</h3>
        </div>
        <div style="display:flex">
            <div class="dashboard-widget">
                <div style="display: flex;flex-direction: row;">
                    <div style="display: flex;justify-content: center;flex-direction: column;">
                        <img style="height: 60px; width: 60px" src="../assets/eth.png" />
                    </div>
                    <div>
                        <h2 style="font-size: 36px;">ETH</h2>
                        <p style="font-size: 26px;">{{ balance }}</p>
                    </div>
                </div>
            </div>
            <div class="dashboard-widget">
                <div style="display: flex;flex-direction: row;">
                    <div>
                        <h2 style="font-size: 36px;">Owned</h2>
                        <p style="font-size: 26px;">{{ ownedItems }}</p>
                    </div>
                </div>
            </div>
            <div class="dashboard-widget">
                <div style="display: flex;flex-direction: row;">
                    <div>
                        <h2 style="font-size: 36px;">Purchased</h2>
                        <p style="font-size: 26px;">{{ purchasedItems.length }}</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="dashboard-widget full">
            <div class='image-container' :key="item" v-for="item of allItems.filter(item => item.owner !== wallet)">
                <div style="display:flex;flex-direction:column;width: 100%;">
                    <img height='200px' width='100%' :src="`http://localhost:3000/static/${item.hash}`" />
                    <p>{{ item.name }}</p>
                </div>
                <div class="buttons-container">
                    <button @click="buyItem(item.hash, item.buyPrice)" class='image-button'>Purchase ({{item.buyPrice}}) wei </button>
                    <button @click="ownItem(item.hash, item.ownPrice)" class='image-button'>Own ({{item.ownPrice}}) wei</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { mapGetters } from 'vuex';
import axios from 'axios'
import abi from '../api/abi'

export default {
    mounted: async function() {
        this.$store.dispatch('reset')
        let allItems = (await axios.get('http://localhost:3000/uploadedFiles')).data.files
        allItems = allItems.map(item => ({ hash: item }))
        console.log('wallet:', this.wallet)
        for (let item of allItems) {
            item.name = await abi.methods.getItemNameFromHash(item.hash).call()
            item.owner = await abi.methods.findOwnerByItem(item.hash).call()
            item.ownPrice = await abi.methods.checkOwnPrice(item.hash).call()
            item.buyPrice = await abi.methods.checkBuyPrice(item.hash).call()
            if (item.owner === this.wallet)
                this.$store.dispatch('incrementOwnedItems')
        }
        this.allItems = allItems
        this.$store.dispatch('loadAllItems', allItems)
        const purchasedItems = (await abi.methods.getBoughtItems(this.wallet).call()).split(',').filter(item => item && item !== ' ')
        this.$store.dispatch('setPurchasedItems', purchasedItems)
        console.log('purchasedItems:', purchasedItems)
        console.log('all items:', allItems)
    },
    data: function() {
        return {}
    },
    computed: mapGetters(['wallet', 'balance', 'contentCount', 'ownedItems', 'allItems', 'purchasedItems']),
    methods: {
        async buyItem(hash, value) {
            const self = this;
            await abi.methods.buyItem(hash).send({
                from: self.wallet,
                value
            })
        },
        async ownItem(hash, value) {
            const self = this;
            await abi.methods.ownItem(hash).send({
                from: self.wallet,
                value
            })
        }
    }
}
</script>

<style>
    .buttons-container {
        display: flex;
        flex-direction: column;
        justify-content: center;
        margin-left: 10px;
        width: 100%;
    }
    .image-button {
        display: inline-block;
        border: 1px solid #ddd;
        padding: 10px;
        border-radius: 5px;
        height: 40px;
        margin: 10px 0px;
    }
    .image-container {
        display: flex;
        flex-basis: 50%;
        max-width: 50%;
        min-width: 50%;
        flex-direction: row !important;
        margin-bottom: 20px;
        padding:10px;
    }
    .image-container img {
        display: inline-block;
    }
    .full {
        width: auto;
        display: flex;
        flex:1;
        flex-wrap: wrap;
    }
</style>
