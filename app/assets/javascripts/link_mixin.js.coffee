window.LinkMixin = 
  navigateLink: (evt) ->
    Backbone.history.navigate evt.currentTarget.pathname, trigger: true
    return false