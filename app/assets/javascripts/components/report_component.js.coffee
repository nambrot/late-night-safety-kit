{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label} = React.DOM

window.ReportComponent = React.createClass
  getTitleText: ->
    "What Happened?"
  
  takePicture: ->
    gUM = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia
    if gUM
      alert "testing" 
      gUM({video: true}, ->
        alert "pooping"

        )




  submitForm: ->
    alert "testing"
    console.log "testing"

  render: ->
    (div id: 'report-component', className: (if @props.visible then 'visible' else 'not-visible'), [
      (h1 {}, "Report bad stuff"),
      (div {}, "What should we text the police?"),
      (input type: "text", ref: "crimeDescription"),
      (input type: "button", value: "Take a picture!", onClick: @takePicture),
      (input type: "button", value: "Submit", onClick: @submitForm)
      ])