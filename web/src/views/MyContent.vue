<template>
    <div>
        <div id="dashboard-subheader">
            <h3 style="display:inline-block;">My Content</h3>
            <form enctype="multipart/form-data" style='display: inline'> 
                <input id='register-button' @change="readFile" type="file" />
            </form>
        </div>
        <div id="pending" v-if="filehash.length > 0">
            <div style="width:100%;">
                <h3>Pending Upload</h3>
                <div>Filename: {{ filename }}</div>
                <div>Content Hash: {{ filehash }}</div>
                <span class='input-container'>Buy Price (wei): <input :value="buyPrice" @change="updateBuy" class='input' /></span>
                <span class='input-container'>Own Price (wei): <input :value="ownPrice" @change="updateOwn" class='input' /></span>
            </div>
            <div style="display:flex;flex-direction:column;justify-content:center;">
                <button @click="registerItem" id="register-file">Register</button>
            </div>
        </div>
        <div class="dashboard-widget full" style="display:flex;">
            <div class='image-container' :key="item" v-for="item of allItems.filter(item => item.owner === wallet)">
                <div style="display:flex;flex-direction:column;width: 100%;">
                    <img height='200px' width='100%' :src="`http://localhost:3000/static/${item.hash}`" />
                    <p>{{ item.name }}</p>
                </div>
                <div class="buttons-container">
                    <button disabled class='image-button'>Purchase ({{item.buyPrice}}) wei </button>
                    <button disabled class='image-button'>Own ({{item.ownPrice}}) wei</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import FileUpload from 'vue-upload-component'
import { keccak256 } from 'web3-utils';
import { mapGetters } from 'vuex'
import abi from '../api/abi'
const axios = require('axios')

export default {
    mounted: async function() {
    },
    components: {
        FileUpload
    },
    data: function() {
        return {
            file: null,
            filename: '',
            filehash: '',
            buyPrice: 0,
            ownPrice: 0
        }
    },
    computed: mapGetters(['wallet', 'allItems']),
    methods: {
        readFile(f) { 
            let self = this;
            this.filename = f.target.files[0].name
            var reader = new FileReader();
            reader.onload = function() {
                self.filehash = keccak256(this.result)
                self.file = this.result
            }
            reader.readAsBinaryString(f.target.files[0]);
        },
        updateOwn(e) {
            this.ownPrice = e.target.value
        },
        updateBuy(e) {
            this.buyPrice = e.target.value
        },
        async registerItem() {
            await axios.post('http://localhost:3000/upload', {
                headers: {
                    'Content-Type': 'application/json'
                },
                filename: this.filename,
                filehash: this.filehash
            })
            let contract = await abi.methods.registerNewItem(this.filehash, this.filename, this.buyPrice, this.ownPrice).send({
                from: this.wallet
            })
        }
    }
}
</script>

<style>
    .input-container {
        display: block;
        margin-top: 5px;
    }
    .input {
        border: 1px solid #ddd;
        padding: 3px 5px;
        border-radius: 3px;
    }
    #register-file {
        padding: 5px 10px;
        border: 1px solid #ddd;
        cursor: pointer;
        border-radius: 5px;
        height: 60px;
        margin-right: 10px;
    }
    *:focus {
        outline: none;
    }
    #pending {
        display:flex;
        border: 2px dashed #ddd;
        margin: 10px 20px;
        padding: 10px;
        border-radius: 5px;
    }
    #register-button {
        float: right;
        border-radius: 3px;
        background-image: linear-gradient(to right, #2c95e8, #428dc7);
        margin-top: 10px;
        padding: 10px 15px;
        color: white;
        font-weight: 600;
        margin-right: 20px;
        cursor: pointer;
    }
</style>
