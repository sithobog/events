initLogin = ->
  $('.signup').on 'click', ->
    $.auth.oAuthSignIn
      provider: 'google'

initLogout = ->
  $('.logout').on 'click', ->
    $.auth.signOut();

configureJToker = ->
  $.auth.configure
    apiUrl: 'http://localhost:3000'
    signOutPath: '/auth/sign_out'
    authProviderPaths: 
      google: '/auth/google_oauth2'

onAuthentication = ->
  PubSub.subscribe('auth.oAuthSignIn.success', ->
    console.log 'LOGGED IN!'
  )

$ ->
  initLogin()
  initLogout()
  onAuthentication()
  configureJToker()