{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label} = React.DOM

class Router extends Backbone.Router

  routes:
    'map': 'map'
    '(/)': 'index'
    '*notFound': 'notFound'
  notFound: ->
    @trigger 'routing', 'notFound'
  index: ->
    @trigger 'routing', 'index'
  map: ->
    @trigger 'routing', 'map'

window.MainComponent = React.createClass
  getInitialState: ->
    page: 'index'
  componentWillMount: ->
    @router = new Router()
    @router.on 'routing', (action) =>
      @setState page: action
  navigateLink: (evt) ->
    @router.navigate evt.currentTarget.pathname, trigger: true
    return false
  
  renderPage: ->
    switch @state.page
      when 'index'
        (div {}, [
          (a href: "/map", onClick: @navigateLink, "Go To Map"),
          (div {}, "I'm the Index")
          ])
        
      when 'map'
        (div {}, [
          (a href: "/", onClick: @navigateLink, "Go To Index"),
          (StaticMapComponent {})
          ])
  render: ->
    (div id: "main-component", [
      (header id: "main-component-header", [
        (h1 {}, "Late Night Safety Kit")
        ]),
      @renderPage()
      ])