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
    @map.locate({setView: true, maxZoom: 16});

    @getData()
  componentDidUpdate: ->
    @map.invalidateSize()

  getData: ->
    $.getJSON "/api/crimes", (crimes) =>
      for crime in crimes
        L.marker([parseFloat(crime.latitude), parseFloat(crime.longitude)])
        .addTo(@map)
        .bindPopup("CRIME: #{crime.incident} on #{crime.dayofweek}")

    $.getJSON "/api/police", (policeStations) =>
      for policeStation in policeStations
        L.marker([parseFloat(policeStation.latitude), parseFloat(policeStation.longitude)])
        .addTo(@map)
        .bindPopup(policeStation.name)

  render: ->
    (div id: 'dynamic-map-component', className: (if @props.visible then 'visible' else 'not-visible'),
    (div className: "map", ref: 'mapEl', style: { height: '500' }))