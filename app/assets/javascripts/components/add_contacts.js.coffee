{div, ul, li, a, header, h1, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label, p} = React.DOM

#root = exports ? this

# root.contactSuccess = (c) ->
#   root.c = contacts;

# root.checkContacts = ->
# 	if typeof navigator.contacts != "undefined"
# 		field = ["displayName"]
# 		navigator.contacts.find(field, contactSuccess)

ContactChoice = React.createClass
	render: ->
		(div {className: 'contactChoice'}, [
			(p {className: 'contactName'}, this.props.name)
			])

ContactChoicesList = React.createClass
	render: ->
		choiceNodes = this.props.list.map( (choice) ->
			ContactChoice name: choice.name)
		(div className: "contactList", choiceNodes)

window.AddContactsComponent = React.createClass
	getInitialState: ->
		{ contacts: [] }
	getTitleText: ->
		"Add Contacts"
	contactSuccess: (contactList) ->
			@setState contacts:contactList
	checkContacts: ->
		console.log this
		unless typeof navigator.contacts is "undefined"
			field = ["displayName"]
			navigator.contacts.find(field, (contactList) =>
				@contactSuccess(contactList))
	componentDidMount: ->
		setTimeout @checkContacts.bind(this), 1000  
	render: ->
		(div id: 'add-contacts-component', className: (if @props.visible then 'visible' else 'not-visible'), [
			(h1 {}, "Add Contacts"),
			(ContactChoicesList list: this.state.contacts)
			])
