{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label, nav} = React.DOM

window.IndexComponent = React.createClass
  navigateLink: (evt) ->
    Backbone.history.navigate evt.currentTarget.pathname, trigger: true
    return false
  render: ->
    (div id: 'index-component', className: (if @props.visible then 'visible' else 'not-visible'), [
      (a href: "/map", onClick: @navigateLink, (StaticMapComponent {})),
      (nav id: 'index-page-nav', [
        (ul {}, [
          (a href: "/map", onClick: @navigateLink, (li {}, "Check the Area")),
          (a href: "/report", onClick: @navigateLink, (li {}, "Something Happened To Me")),
          (a href: "/homewalker", onClick: @navigateLink, (li {}, "HomeWalker (TM)")),
          (a href: "/additional_resources", onClick: @navigateLink, (li {}, "Additional Resources"))
          ])
        ])
      ])