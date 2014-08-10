class @User extends Backbone.Model
  initialize: ->
    @firebase = new Firebase("https://late-night-safety-ki.firebaseio.com/")
    localStorage.setItem("id", new Date().getTime()) unless localStorage.getItem("id")
    @id = localStorage.getItem("id")
    @firebaseRef = @firebase.child(@id)
    @currentLocation = null
    @initiateTrack()
  initiateTrack: ->
    if navigator.geolocation
      @watchTrack = navigator.geolocation.watchPosition (position) => (@updateLocation(position))
  updateLocation: (position) ->
    @currentLocation = position
    @firebaseRef.set location: position
    @trigger 'location', position