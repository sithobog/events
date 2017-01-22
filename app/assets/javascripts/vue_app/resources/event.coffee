$ ->

  Vue.component 'events_index',
    template: "
      <div class='container'>
        <h3>Index</h3>
        <div class='row' v-for='event in events'>
          <router-link v-bind:event_id='event.id' v-bind:to=\"'events/' + event.id\">{{event.purpose}}</router-link>
          <div class='col-sm-3'>{{event.date}}</div>
          <div class='col-sm-3'>{{event.place}}</div>
          <div class='col-sm-3'>{{event.description}}</div>
        </div>
      </div>"
    data: ->
      events: []
    beforeCreate: ->
      self = this
      $.ajax
        type: 'GET'
        dataType: 'json'
        url: 'http://localhost:3000/api/v1/events'
        beforeSend: (xhr, settings) ->
          $.auth.appendAuthHeaders(xhr, settings)
        error: ->
          console.log 'ERROR'
        success: (data) ->
          self.events = data

  Vue.component 'events_show',
    template: "
      <div class='container'>
        <h3>Show {{$route.params.id}}</h3>
        <div>Date: {{event.date}}</div>
        <div>Purpose: {{event.purpose}}</div>
        <div>Place: {{event.place}}</div>
        <div>Description: {{event.description}}</div>
      </div>"
    props: ['event_id']
    data: ->
      event: {}
    created: ->
      self = this
      $.ajax
        type: 'GET'
        dataType: 'json'
        url: 'http://localhost:3000/api/v1/events/' + self.event_id
        beforeSend: (xhr, settings) ->
          $.auth.appendAuthHeaders(xhr, settings)
        error: ->
          console.log 'ERROR'
        success: (data) ->
          self.event = data