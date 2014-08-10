# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require jquery
#= require jquery_ujs
#= require foundation
#= require leaflet
window.initTrack = (id) ->
  firebase = new Firebase("https://late-night-safety-ki.firebaseio.com/")
  firebaseRef = firebase.child(id)
  map = L.map $('#map')[0]
  .setView([42.3581,-71.0636], 10)

  L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map)
  marker = null
  firebaseRef.on 'value', (snapshot) ->
    pos = snapshot.val().location
    lat = pos.coords.latitude
    lng = pos.coords.longitude
    latAccuracy = 180 * pos.coords.accuracy / 40075017
    lngAccuracy = latAccuracy / Math.cos((Math.PI / 180) * lat)
    bounds = L.latLngBounds([lat - latAccuracy, lng - lngAccuracy], [lat + latAccuracy, lng + lngAccuracy])
    zoom = map.getBoundsZoom bounds
    map.setView [lat, lng], zoom
    marker = L.marker [lat, lng], icon: L.icon(iconUrl: 'http://openmbta.org/images/map/TrackingDot.png') unless marker
    marker.setLatLng([lat, lng]).addTo map