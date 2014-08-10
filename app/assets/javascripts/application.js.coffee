# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require foundation
#= require underscore
#= require backbone
#= require backbone.localstorage
#= require react
#= require backbone_mixin
#= require link_mixin
#= require moment
#= require_tree ./models
#= require_tree ./components


$ ->
  $(document).foundation()
  window.emergency_contacts = new EmergencyContacts()
  emergency_contacts.fetch()
  window.user = new User()
  window.main_component = React.renderComponent (MainComponent emergency_contacts: emergency_contacts), document.getElementById('container')
  Backbone.history.start pushState: true, trigger: true
