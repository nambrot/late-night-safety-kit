{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label} = React.DOM

class Router extends Backbone.Router

  routes:
    'test': 'test'
    '(/)': 'index'
    '*notFound': 'notFound'
  notFound: ->
    @trigger 'routing', 'notFound'
  index: ->
    @trigger 'routing', 'index'
  test: ->
    @trigger 'routing', 'test'

window.MainComponent = React.createClass
  componentWillMount: ->
    @router = new Router()
    @router.on 'routing', (action) =>
      console.log 'routing'
      console.log action
  navigateLink: (evt) ->
    @router.navigate evt.currentTarget.pathname, trigger: true
    return false

  render: ->
    (div id: "main-component", [
      (header id: "main-component-header", [
        (h1 {}, "Late Night Safety Kit")
        ]),
      (ul {}, [
        (a href: "/test", onClick: @navigateLink, (li {}, "Some options"))
        (a {}, (li {}, "Some options"))
        (a {}, (li {}, "Some options"))
        (a {}, (li {}, "Some options"))        
        ])
      ])