// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import './plugins/vuetify'
import App from './App'
import router from './router'
import Vuex from 'vuex'
import Vuetify from 'vuetify'
import web3 from './api/web3'

import '@mdi/font/css/materialdesignicons.css' // Ensure you are using css-loader

Vue.use(Vuetify, {
  iconfont: 'mdi'
})
Vue.use(Vuex)

Vue.config.productionTip = false

const store = new Vuex.Store({
  state: {
    wallet: '',
    balance: 0
  },
  mutations: {
    setWallet(state,wallet) {state.wallet = wallet},
    setBalance(state, balance) { state.balance = balance }
  },
  actions: {
    async setWallet({state, commit}, wallet) { 
      commit('setWallet', wallet) 
      commit('setBalance', ((await web3.eth.getBalance(state.wallet)) / 1000000000000000000).toFixed(3))
    }
  },
  getters: {
    wallet(state) { return state.wallet },
    balance(state) { return state.balance }
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
