{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label, nav} = React.DOM

class Router extends Backbone.Router

  routes:
    '(/)': 'index'
    '*page': 'page'
  index: ->
    @trigger 'routing', 'index'
  page: (page) ->
    @trigger 'routing', page

window.MainComponent = React.createClass
  getInitialState: ->
    page: 'index'
    view: (IndexComponent {})
  componentWillMount: ->
    @router = new Router()
    @router.on 'routing', (action) =>
      @setState page: action
  navigateLink: (evt) ->
    @router.navigate evt.currentTarget.pathname, trigger: true
    return false
  getCurrentComponent: ->
    @refs[@state.page]
  getTitleText: ->
    return @getCurrentComponent().getTitleText() if @getCurrentComponent() and @getCurrentComponent().getTitleText
    return "Late Night Safety Kit"
  renderPage: ->
    @state.view
  render: ->
    (div id: "main-component", [
      (header id: "main-component-header", [
        (a className: 'back-botton', href: '/', onClick: @navigateLink) unless @state.page is 'index'
        (h1 {}, @getTitleText())
        ])
      ].concat([
        (IndexComponent visible: (@state.page is 'index'), ref: 'index'),
        (DynamicMapComponent visible: (@state.page is 'map'), ref: 'map'),
        (ReportComponent visible: (@state.page is 'report'), ref: 'report')
        ]))