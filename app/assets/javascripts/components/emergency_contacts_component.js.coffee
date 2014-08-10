{div, ul, li, a, header, h1, h2, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label, p, form} = React.DOM

window.EmergencyContactsComponent = React.createClass
  getTitleText: ->
    "Emergency Contacts"
  getBackboneObject: ->
    window.emergency_contacts
  mixins: [LinkMixin, BackboneMixin]
  addEmergencyContact: ->
    emergency_contacts.create name: @refs.name.getDOMNode().value, number: @refs.number.getDOMNode().value
    @refs.name.getDOMNode().value = ''
    @refs.number.getDOMNode().value = ''
    return false
  render: ->
    (div id: 'emergency-contacts-component', className: (if @props.visible then 'visible' else 'not-visible'), [
      (h3 {}, "Currently Listed Emergency Contacts of yours"),
      (ul {}, window.emergency_contacts.map (contact) ->
        (li {}, "#{contact.get('name')}: #{contact.get('number')}")
        )
      (p className: 'center', (a href: "/add_contacts", onClick: @navigateLink, className: "button", "Add Contacts from Address Book")),
      (form {},[
        (h3 {}, "Add Additional Emergency Contact")
        (label className: 'small-12 columns', (input ref: "name", type: 'text', placeholder: "Name")),
        (label className: 'small-12 columns', (input ref: "number", type: 'text', placeholder: "Number")),
        (p className: 'center', (a href: "/add_contacts", onClick: @addEmergencyContact, className: "button", "Add Emergency Contact"))
        ])

      ])
