{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label} = React.DOM

window.ReportComponent = React.createClass
  getTitleText: ->
    "What Happened?"

  submitForm: ->
    $.post "/reports", report: { latitude: user.currentLocation.coords.latitude, longitude: user.currentLocation.coords.longitude, image: @refs.file.getDOMNode().value, description: @refs.crimeDescription.getDOMNode().value }
    .success (evt) =>
      alert("Police have been notified")
    .fail (evt) =>
      alert("Something went wrong with the report")

  render: ->
    (div id: 'report-component', className: (if @props.visible then 'visible' else 'not-visible'), [
      (h1 {}, "Report something"),
      (div {}, "Email the police with a photo and your location"),
      (input type: "text", ref: "crimeDescription"),
      (input type: "hidden", name: "picture", role:"uploadcare-uploader", ref: "file"),
      (input type: "button", value: "Submit", onClick: @submitForm)
      ])