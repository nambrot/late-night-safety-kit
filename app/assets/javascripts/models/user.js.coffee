class @User
  constructor: () ->
    @firebase = new Firebase("https://late-night-safety-ki.firebaseio.com/")
    localStorage.setItem("id", new Date().getTime()) unless localStorage.getItem("id")
    @id = localStorage.getItem("id")
    @firebaseRef = @firebase.child(@id)
    @initiateTrack()
  initiateTrack: ->
    if navigator.geolocation
      @watchTrack = navigator.geolocation.watchPosition (position) => (@updateLocation(position))
  updateLocation: (position) ->
    @firebaseRef.set location: position
