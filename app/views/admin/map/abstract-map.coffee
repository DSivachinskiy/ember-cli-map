`import Ember from 'ember'`

abstractMapView = Ember.View.extend
  templateName: "admin/_geo"

  lat: (->
    @get("context.#{@get('latAttr')}")
  ).property()

  setLan: (value) ->
    @get('context').set(@get('latAttr'), value)

  latAttr:(->
    @get("context.#{@get('mapType')}")[0]
  ).property()

  long:(->
    @get("context.#{@get('longAttr')}")
  ).property()

  longAttr:(->
    @get("context.#{@get('mapType')}")[1]
  ).property()

  setLong: (value) ->
    @get('context').set(@get('longAttr'), value)

  zoom:(->
    @get("context.#{@get('zoomAttr')}") || 8
  ).property()

  zoomAttr: (->
    @get("context.#{@get('mapType')}")[2]
  ).property()

  setZoom: (value) ->
    @get('context').set(@get('zoomAttr'), value)

  centerCoords: ->
    if @get('lat') && @get('long')
      [@get('lat'), @get('long')]
    else
      ["50.44067063154785","30.52654266357422"]

  setAttrs: (pos) ->
    if pos['push']
      @setLat(pos[0])
      @setLong(pos[1])
    else
      @setLat(pos.ob)
      @setLong(pos.pb)

`export default abstractMapView`