@BackboneMixin = 
  _boundForceUpdate: ->
    if @isMounted()
      @forceUpdate()
  componentDidMount: ->
    triggerRenderEvents = @triggerRenderEvents || "all"
    throttledReRenderWait = @throttledReRenderWait || 200
    @getBackboneObject().on triggerRenderEvents, _.debounce(@_boundForceUpdate, throttledReRenderWait)
  componentWillUnmount: ->
    triggerRenderEvents = @triggerRenderEvents || "all"
    throttledReRenderWait = @throttledReRenderWait || 200
    @getBackboneObject().off triggerRenderEvents, _.debounce(@_boundForceUpdate, throttledReRenderWait)