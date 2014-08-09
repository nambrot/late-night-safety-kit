#= require backbone
#= require backbone.localstorage
class @EmergencyContact extends Backbone.Model
  validate: (attrs, options) ->
    return "no name" unless attrs.name
    return "no number" unless attrs.number
    return 
class @EmergencyContacts extends Backbone.Collection
  model: EmergencyContact
  localStorage: new Backbone.LocalStorage("EmergencyContacts")