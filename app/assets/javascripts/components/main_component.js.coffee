{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label} = React.DOM

window.MainComponent = React.createClass
  render: ->
    (div id: "main-component", [
      (header id: "main-component-header", [
        (h1 {}, "Late Night Safety Kit")
        ]),
      (ul {}, [
        (a {}, (li {}, "Some options"))
        (a {}, (li {}, "Some options"))
        (a {}, (li {}, "Some options"))
        (a {}, (li {}, "Some options"))        
        ])
      ])