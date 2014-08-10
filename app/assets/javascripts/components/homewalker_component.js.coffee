#= require link_mixin
{div, ul, li, a, header, h1,h2, h3, h6, b, table, thead, tbody, tr, th, td, hr, span, input, section, textarea, footer, select, option, label, p, form} = React.DOM

window.HomeWalkerComponent = React.createClass
  mixins: [LinkMixin, BackboneMixin]
  getInitialState: ->
    selectedEmergencyContacts: []
    timer: if localStorage.getItem("timer_expires_at") then new Date((localStorage.getItem("timer_expires_at"))) else false
  getBackboneObject: ->
    window.emergency_contacts
  componentDidMount: ->
    @countdown() if @state.timer
  getTitleText: ->
    "HomeWalker"
  onSelectEmergencyContactChange: (selectedEmergencyContacts) ->
    @setState selectedEmergencyContacts: selectedEmergencyContacts
  sendRealtimeLink: ->
    for contactId in @state.selectedEmergencyContacts
      contact = emergency_contacts.get(contactId)
      $.get "/api/sendtext", to: contact.get('number'), msg: "#{contact.get('name')}, someone send you a link to real time track them on their walk, check it out at #{window.location.origin}/tracks/#{user.id}"
      .success (evt) ->
        alert("Successfully send link to #{contact.get('name')}")
      .fail (evt) ->
        alert("Could not send link to #{contact.get('name')}")
    return false
  setTimer: ->
    if @state.selectedEmergencyContacts.length == 0
      alert("Select Emergency Contacts first")
      return
    if @refs.timerInMinutes.getDOMNode().value <= 0
      alert("Set a valid timer")
      return
    $.post "/timers", timer: { expires_at: new Date(new Date() - (-1000 * 60 * @refs.timerInMinutes.getDOMNode().value)), user_id: user.id, numbers: JSON.stringify(@state.selectedEmergencyContacts.map((id) -> emergency_contacts.get(id).attributes )) }
    .success (evt) =>
      localStorage.setItem("timer_expires_at", new Date(new Date() - (-1000 * 60 * @refs.timerInMinutes.getDOMNode().value)))
      @setState timer: new Date(new Date() - (-1000 * 60 * @refs.timerInMinutes.getDOMNode().value))
      alert("Set Timer, please be safe")
      @countdown()
    .fail (evt) =>
      alert("Setting Timer failed")
    return false
  countdown: ->
    if @state.timer
      if moment().isAfter(moment(@state.timer))
        # go nuts
        alert("We have not received an update from you, so we went ahead and send a message to your emergency contacts")
        @removeTimer()
      else
        @_boundForceUpdate()
        setTimeout @countdown.bind(this), 1000
  removeTimer: ->
    @setState timer: false
    localStorage.removeItem "timer_expires_at"
  destroyTimer: ->
    alert("No Timer to remove") unless @state.timer
    $.ajax url: "/timers/#{user.id}", type: 'DELETE'
    .success (evt) =>
      @removeTimer()
      alert("Removed Timer, glad you are safe")
    .fail (evt) =>
      alert("Failed to remove Timer")
  countdownTime: ->
    now = moment()
    ms = moment(@state.timer).diff(now, 'milliseconds', true);
    moment.duration(ms)
  renderTimerComponent: ->
    if @state.timer
      (div {}, [
        (h3 className: 'center', "You have set a timer")
        (h2 className: 'center', "in #{@countdownTime().humanize()}"),
        (p className: 'center', (a className: 'button', onClick: @destroyTimer, "I'm safe")),
        (p {}, "We will text your emergency contacts if you don't press the above button when the timer runs out")
        ])
    else
      (div {}, [
        (h3 {}, "Timer Stuff"),
        (p {}, "Set a timer and we'll send a message if you dont check back with us"),
        (form className: "new-timer-form", [
          (span {}, "in"),
          (input ref: "timerInMinutes", defaultValue: 30),
          (span {}, "minutes")
          ])
        (p className: 'center', (a className: "button center", onClick: @setTimer, "Set Timer"))
        ])
  render: ->
    (div id: 'home-walker-component', className: (if @props.visible then 'visible' else 'not-visible'), [
      (p {}, "Homewalker is your tool to get home safely.  Also set yourself a timer timer and we'll check on you, if you dont check in with us again, we'll send a message to your emergency contacts"),
      (h6 {}, "Select your Emergency Contacts to send to"),
      (SelectEmergencyContactComponent onChange: @onSelectEmergencyContactChange),
      (p className: 'center', (a href: '/emergency_contacts', className: "button", onClick: @navigateLink, "Add Emergency Contacts")),
      @renderTimerComponent()
      (h3 {}, "Real Time Tracking")
      (p {}, ["Send your friends and family a realtime tracking link so that they can check on you. ", (a href: "#{window.location.origin}/tracks/#{user.id}", "#{window.location.origin}/tracks/#{user.id}")]),
      (p className: 'center', (a className: "button center", onClick: @sendRealtimeLink, "Send them Realtime tracking link")),
      
      ])