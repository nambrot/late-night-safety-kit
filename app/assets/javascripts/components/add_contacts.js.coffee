{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label, p} = React.DOM

#root = exports ? this

# root.contactSuccess = (c) ->
#   root.c = contacts;

# root.checkContacts = ->
# 	if typeof navigator.contacts != "undefined"
# 		field = ["displayName"]
# 		navigator.contacts.find(field, contactSuccess)

ContactChoice = React.createClass
	getInitialState : ->
		return checked: false
	handleChange: (event) ->
		@setState checked: event.target.checked
	render: ->
		value = this.state.value
		(label {}, this.props.name.formatted, [(input {value: this.props.name.formatted, type: 'checkbox', onChange: @handleChange, checked: @state.checked, className: 'contactName'})])

ContactChoicesList = React.createClass
	submitNames: ->
		$.each $('.contactName:checked'), (index, input) =>
			person = _.find this.props.list, (c) ->
				c.name.formatted == input['value']
			emergency_contacts.create name: person.name.formatted, number: person['phoneNumbers'][0]['value']
		@navigateLink
	render: ->
		choiceNodes = this.props.list.map( (choice) ->
			ContactChoice name: choice.name)
		(div { className: "contactList row"}, choiceNodes.concat([
			(a href: '/emergency_contacts', className: "button", onClick: @submitNames, "Submit")
		]))

window.AddContactsComponent = React.createClass
	getInitialState: ->
		{ contacts: [] }
	getTitleText: ->
		"Add Contacts"
	contactSuccess: (contactList) ->
			@setState contacts:contactList
	checkContacts: ->
		unless typeof navigator.contacts is "undefined"
			field = ["displayName"]
			navigator.contacts.find(field, (contactList) =>
				@contactSuccess(contactList))
	componentDidUpdate: ->
		unless this.state.contacts.length > 0
			@checkContacts()
	render: ->
		(div id: 'add-contacts-component', className: (if @props.visible then 'visible' else 'not-visible').concat(' row'), [
			(h1 {}, "Add Contacts"),
			(ContactChoicesList list: this.state.contacts)
			])
