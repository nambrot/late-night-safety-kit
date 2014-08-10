{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label, p} = React.DOM

window.SelectEmergencyContactComponent = React.createClass
  getInitialState: ->
    selected: []
  onChange: (evt) ->
    id = evt.target.value
    selected = @state.selected
    if (index = @refs.select.props.value.indexOf(id)) is -1
      selected.push id
    else
      selected.splice index, 1
    @setState selected: selected
    @props.onChange @state.selected if @props.onChange
  render: ->
    (select onChange: @onChange, ref: "select", value: @state.selected, multiple: "multiple", style: { height: window.emergency_contacts.length * 30 }, window.emergency_contacts.map (emergency_contact) =>
      (option value: emergency_contact.get('id'), "#{emergency_contact.get('name')}: #{emergency_contact.get('number')}")
      )