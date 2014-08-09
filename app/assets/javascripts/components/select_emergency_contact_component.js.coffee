{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label, p} = React.DOM

window.SelectEmergencyContactComponent = React.createClass
  render: ->
    (select multiple: "multiple", style: { height: window.emergency_contacts.length * 30 }, window.emergency_contacts.map (emergency_contact) =>
      (option value: emergency_contact.get('name'), "#{emergency_contact.get('name')}: #{emergency_contact.get('number')}")
      )