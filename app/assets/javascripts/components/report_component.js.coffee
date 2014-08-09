{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label} = React.DOM

window.ReportComponent = React.createClass
  render: ->
    (div id: 'report-component', [
      (h3 {}, "Im the Report Component")
      ])