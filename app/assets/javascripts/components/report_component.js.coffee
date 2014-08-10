{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label} = React.DOM

window.ReportComponent = React.createClass
  getTitleText: ->
    "What Happened?"

  submitForm: ->
    debugger
    $.post "/reports", report: { latitude: user.currentLocation.coords.latitude, longitude: user.currentLocation.coords.longitude, image: @refs.file.getDOMNode().value, description: @refs.crimeDescription.getDOMNode().value }
    .success (evt) =>
      console.log 'evt'
    .fail (evt) =>
      console.log evt
    alert "testing"
    console.log "testing"

  render: ->
    (div id: 'report-component', className: (if @props.visible then 'visible' else 'not-visible'), [
      (h1 {}, "Report bad stuff"),
      (div {}, "What should we text the police?"),
      (input type: "text", ref: "crimeDescription"),
      (input type: "hidden", name: "picture", role:"uploadcare-uploader", ref: "file"),
      (input type: "button", value: "Submit", onClick: @submitForm)
      ])