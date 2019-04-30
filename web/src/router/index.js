import Vue from 'vue'
import Router from 'vue-router'
import Dashboard from '@/views/Dashboard'
import MyContent from '@/views/MyContent'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/Dashboard',
      alias: '/',
      name: 'Dashboard',
      component: Dashboard
    },
    {
      path: '/MyContent',
      name: 'MyContent',
      component: MyContent
    }
  ]
})