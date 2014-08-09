{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label, nav} = React.DOM

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
        (div id: 'index-page', [
          
          (a href: "/map", onClick: @navigateLink, (StaticMapComponent {})),
          (nav id: 'index-page-nav', [
            (ul {}, [
              (a href: "/map", onClick: @navigateLink, (li {}, "Check the Area")),
              (a href: "/map", onClick: @navigateLink, (li {}, "Something Happened To Me")),
              (a href: "/map", onClick: @navigateLink, (li {}, "Check on Me"))
              ])
            ])
          ])
        
      when 'map'
        (div {}, [
          (a href: "/", onClick: @navigateLink, "Go To Index"),
          (DynamicMapComponent {})
          ])
  render: ->
    (div id: "main-component", [
      (header id: "main-component-header", [
        (h1 {}, "Late Night Safety Kit")
        ]),
      @renderPage()
      ])