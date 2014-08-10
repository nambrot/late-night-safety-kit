#= require leaflet
{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label} = React.DOM

window.DynamicMapComponent = React.createClass
  componentDidMount: ->
    @map = L.map @refs.mapEl.getDOMNode()
      .setView([42.3581,-71.0636], 10)

    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(@map)

    # get user location
    window.user.on 'location', @setFromUserLocation, this
    @setFromUserLocation()
    @getData()
  setFromUserLocation: ->
    if window.user.currentLocation
      pos = window.user.currentLocation
      @map.setView [pos.coords.latitude, pos.coords.longitude], 15
  componentDidUpdate: (prevProps, prevState) ->
    @map.invalidateSize()
    @map.setView([42.3581,-71.0636], 10)
    @setFromUserLocation()

  getData: ->
    
    $.getJSON "/api/crimes", (crimes) =>
      for crime in crimes
        L.marker([parseFloat(crime.latitude), parseFloat(crime.longitude)], icon: L.icon(iconUrl: 'https://www.zeroaggressionproject.org/wp-content/uploads/2013/10/crime-icon.png', iconSize: [40, 40]))
        .addTo(@map)
        .bindPopup("CRIME: #{crime.incident} on a #{crime.dayofweek} at #{crime.time}")

    $.getJSON "/api/police", (policeStations) =>
      for policeStation in policeStations
        L.marker([parseFloat(policeStation.latitude), parseFloat(policeStation.longitude)], icon: L.icon(iconUrl: 'http://icongal.com/gallery/image/255467/car_police_auto_vehicle_transport_train_police_station_music_instrument.png', iconSize: [70, 70]))
        .addTo(@map)
        .bindPopup(policeStation.name)

  render: ->
    (div id: 'dynamic-map-component', className: (if @props.visible then 'visible' else 'not-visible'),
    (div className: "map", ref: 'mapEl', style: { height: '500' }))
