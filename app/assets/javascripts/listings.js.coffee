# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ -> new class Map
  constructor: ->
    if $('#map')[0]
      navigator.geolocation.getCurrentPosition (position) =>
        {latitude, longitude} = position.coords

        @map = new google.maps.Map $('#map div')[0],
          disableDefaultUI: true
          center: new google.maps.LatLng(latitude, longitude)
          zoom: 14

        google.maps.event.addListenerOnce @map, 'tilesloaded', ->
          $('#map div').css 'opacity', '1'

        new google.maps.Marker
          map: @map
          title: 'Me'
          position: new google.maps.LatLng(latitude, longitude)

        for i in [0..10]
          new Barker
            map: @map
            position: new google.maps.LatLng(latitude + 0.04 * (Math.random() - 0.5), longitude + 0.04 * (Math.random() - 0.5))

class Barker
  constructor: ({map, position}) ->
    @marker = new google.maps.Marker
      map: map
      position: position
      title: 'Doge'
      icon: '/doge-pin.png'

    google.maps.event.addListener @marker, 'click', @open

  open: (event) => new Doge {}

class Doge
  constructor: ({name}) ->
    @el = $ '<div class="doge">'
      .append """
        <div class="close">&#215;</div>
        <div class="name">
          <img src="/doge-pin.png" />
          #{name}
        </div>
      """
      .on 'click', '.close', @close
      .appendTo 'body'

  close: =>
    @el.remove()
