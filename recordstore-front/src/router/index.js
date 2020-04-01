import Vue from 'vue'
import Router from 'vue-router'
import Signin from '@/components/signin.vue'
import Signup from '@/components/signup.vue'
import Records from '@/components/records.vue'
import Artists from '@/components/artists.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Signin',
      component: Signin
    },
    {
      path: '/signup',
      name: 'Signup',
      component: Signup
    },
    {
      path: '/artists',
      name: 'Artists',
      component: Artists
    },
    {
      path: '/records',
      name: 'Records',
      component: Records
    }
  ]
})
