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
