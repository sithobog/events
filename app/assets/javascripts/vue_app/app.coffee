$ ->

  configureJToker = ->
    $.auth.configure
      apiUrl: 'http://localhost:3000'
      signOutPath: '/auth/sign_out'
      authProviderPaths: 
        google: '/auth/google_oauth2'

  configureJToker()

  index_view = Vue.component('events_index')
  show_view = Vue.component('events_show')


  routes = [
    {
      path: '/index'
      component: index_view
    }
    {
      path: '/events/:event_id'
      component: show_view
    }
  ]
  # 3. Create the router instance and pass the `routes` option
  # You can pass in additional options here, but let's
  # keep it simple for now.
  router = new VueRouter(routes: routes)
  # 4. Create and mount the root instance.
  # Make sure to inject the router with the router option to make the
  # whole app router-aware.
  app = new Vue(router: router).$mount('#app')