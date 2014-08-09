#= require link_mixin
{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label, p} = React.DOM

window.HomeWalkerComponent = React.createClass
  mixins: [LinkMixin, BackboneMixin]
  getBackboneObject: ->
    window.emergency_contacts
  getTitleText: ->
    "HomeWalker"
  render: ->
    (div id: 'home-walker-component', className: (if @props.visible then 'visible' else 'not-visible'), [
      (p {}, "Homewalker is your tool to get home safely. Send your friends and family a realtime tracking link so that they can check on you. Also set yourself a timer timer and we'll check on you, if you dont check in with us again, we'll send a message to your emergency contacts"),
      (p className: 'center', (a href: '/emergency_contacts', className: "button", onClick: @navigateLink, "Add Emergency Contacts")),
      (h6 {}, "Select your Emergency Contacts to send to"),
      (SelectEmergencyContactComponent {}),
      (p className: 'center', (a className: "button center", "Send them Realtime tracking link"))

      ])