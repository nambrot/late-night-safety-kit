{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label, p} = React.DOM

window.EmergencyContactsComponent = React.createClass
  getTitleText: ->
    "Emergency Contacts"
  render: ->
    (div id: 'emergency-contacts-component', className: (if @props.visible then 'visible' else 'not-visible'), [
      (p {}, "Emergency Contacts")
      ])