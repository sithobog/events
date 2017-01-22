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

showEvent = ->
  $('.single_event').on 'click', ->
    requestShow()

indexEvent = ->
  $('.all_events').on 'click', ->
    requestIndex()

createEvent = ->
  $('.create_event').on 'click', ->
    requestCreate()

updateEvent = ->
  $('.update_event').on 'click', ->
    requestUpdate()

destroyEvent = ->
  $('.destroy_event').on 'click', ->
    requestDestroy()

requestShow = ->
  $.ajax
    type: 'GET'
    dataType: 'json'
    url: 'http://localhost:3000/api/v1/events/1'
    beforeSend: (xhr, settings) ->
      $.auth.appendAuthHeaders(xhr, settings)
    error: ->
      console.log 'ERROR'
    success: (data) ->
      console.log 'SUCCESS'
      console.log data

requestCreate = ->
  $.ajax
    type: 'POST'
    dataType: 'json'
    url: 'http://localhost:3000/api/v1/events'
    data:
      event:
        date: new Date()
        place: 'Some place'
        purpose: 'Some purpose'
        description: 'Some description'
    beforeSend: (xhr, settings) ->
      $.auth.appendAuthHeaders(xhr, settings)
    error: ->
      console.log 'ERROR'
    success: (data) ->
      console.log 'SUCCESS'
      console.log data

requestDestroy = ->
  $.ajax
    type: 'DELETE'
    dataType: 'json'
    url: 'http://localhost:3000/api/v1/events/4'
    beforeSend: (xhr, settings) ->
      $.auth.appendAuthHeaders(xhr, settings)
    error: ->
      console.log 'ERROR'
    success: (data) ->
      console.log 'SUCCESS'
      console.log data

requestUpdate = ->
  $.ajax
    type: 'PUT'
    dataType: 'json'
    url: 'http://localhost:3000/api/v1/events/4'
    data:
      event:
        # date: new Date()
        # place: 'Some place'
        # purpose: 'Some purpose' 
        description: 'I DID IT!!!'
    beforeSend: (xhr, settings) ->
      $.auth.appendAuthHeaders(xhr, settings)
    error: ->
      console.log 'ERROR'
    success: (data) ->
      console.log 'SUCCESS'
      console.log data         

requestIndex = ->
  $.ajax
    type: 'GET'
    dataType: 'json'
    url: 'http://localhost:3000/api/v1/events'
    beforeSend: (xhr, settings) ->
      $.auth.appendAuthHeaders(xhr, settings)
    error: ->
      console.log 'ERROR'
    success: (data) ->
      console.log 'SUCCESS'
      console.log data

$ ->
  initLogin()
  initLogout()
  onAuthentication()
  showEvent()
  indexEvent()
  createEvent()
  updateEvent()
  destroyEvent()
  configureJToker()