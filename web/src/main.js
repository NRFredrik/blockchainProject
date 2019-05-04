// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import './plugins/vuetify'
import App from './App'
import router from './router'
import Vuex from 'vuex'
import Vuetify from 'vuetify'
import web3 from './api/web3'
import abi from './api/abi'

import '@mdi/font/css/materialdesignicons.css' // Ensure you are using css-loader

Vue.use(Vuetify, {
  iconfont: 'mdi'
})
Vue.use(Vuex)

Vue.config.productionTip = false

const store = new Vuex.Store({
  state: {
    wallet: '',
    balance: 0,
    contentCount: 0,
    ownedItems: 0,
    allItems: [],
    purchasedItems: 0
  },
  mutations: {
    setWallet(state,wallet) {state.wallet = wallet},
    setBalance(state, balance) { state.balance = balance },
    setContentCount(state, content) { console.log('CONT:', content)},
    incrementOwnedItems(state) { state.ownedItems = state.ownedItems + 1},
    loadAllItems(state, allItems) { state.allItems = [ ...allItems ]},
    reset(state) {
      state.ownedItems = 0
      state.allItems = []
    },
    setPurchsedItems(state, purchasedItems) { 
      state.purchasedItems = purchasedItems
    }
  },
  actions: {
    async setWallet({state, commit}, wallet) { 
      commit('setWallet', wallet) 
      commit('setBalance', ((await web3.eth.getBalance(state.wallet)) / 1000000000000000000).toFixed(3))
      commit('setContentCount', await abi.methods.getOwnedItems(state.wallet).call())
    },
    incrementOwnedItems({state, commit}){ 
      commit('incrementOwnedItems')
    },
    loadAllItems({state, commit}, allItems) { commit('loadAllItems', allItems)},
    reset({commit}) {commit('reset')},
    setPurchasedItems({state, commit}, purchasedItems) { commit('setPurchsedItems', purchasedItems) }
  },
  getters: {
    wallet(state) { return state.wallet },
    balance(state) { return state.balance },
    contentCount(state) { return state.contentCount },
    ownedItems(state) { return state.ownedItems },
    allItems(state) { return state.allItems },
    purchasedItems(state) { return state.purchasedItems }
  }
})

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>'
})
