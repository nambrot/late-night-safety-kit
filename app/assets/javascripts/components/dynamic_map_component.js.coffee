#= require leaflet
{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label} = React.DOM

window.DynamicMapComponent = React.createClass
  componentDidMount: ->
    map = L.map @refs.mapEl.getDOMNode()
      .setView([42.3581,-71.0636], 10)

    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map)
  render: ->
    (div className: "map", ref: 'mapEl', style: { height: '500' })