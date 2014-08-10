{div, ul, li, a, header, h1, h2, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label, p} = React.DOM

window.EmergencyContactsComponent = React.createClass
  getTitleText: ->
    "Emergency Contacts"
  getBackboneObject: ->
    window.emergency_contacts
  mixins: [LinkMixin, BackboneMixin]
  render: ->
    (div id: 'emergency-contacts-component', className: (if @props.visible then 'visible' else 'not-visible'), [
      (h3 {}, "Currently Listed Emergency Contacts of yours"),
      (ul {}, window.emergency_contacts.map (contact) ->
        (li {}, "#{contact.get('name')}: #{contact.get('number')}")
        )
      (p className: 'center', (a href: "/add_contacts", onClick: @navigateLink, className: "button", "Add Contacts from Address Book"))
      ])