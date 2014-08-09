{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label} = React.DOM

window.ReportComponent = React.createClass
  getTitleText: ->
    "What Happened?"
  render: ->
    (div id: 'report-component', className: (if @props.visible then 'visible' else 'not-visible'), [
      (h3 {}, "Im the Report Component")
      ])