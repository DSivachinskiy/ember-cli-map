`import Ember from 'ember'`
`import AbstractMapMixin from 'ember-map/mixins/abstract-map'`

yandexMapView = Ember.Component.extend AbstractMapMixin,

  mapType: 'asYandexMap'

  didInsertElement: ->
    self = @
    console.log ymaps
    ymaps.ready(=>@initMap.call(self))

  initMap: ->
    map = new ymaps.Map(this.get('childId'), {
      center: @get('center'),
      zoom: @get('zoom')
    })
    @initMarker(map)

    map.controls
    .add('zoomControl', { left: 5, top: 5})
    .add('typeSelector')
    .add('mapTools', { left: 35, top: 5 })

    #Todo create zoom change event and autocomplete from yandex

    @initAutocomplete()

  center: (->
    @centerCoords()
  ).property()

  initMarker: (map) ->
    mark = new ymaps.Placemark(@get('center'), {
      iconContent: '1',
      balloonContent: '',
      hintContent: ''
    }, {
      preset: 'twirl#violetIcon'
      draggable: true
    })

    map.geoObjects.add(mark)

    mark.events.add "dragend", (e) =>
      @setAttrs(mark.geometry.getCoordinates())

  initAutocomplete: (map, marker) ->
    autocompleteView = @get('MapAutocomplete')
    console.log(autocompleteView)
    input =  autocompleteView.$().hide()

`export default yandexMapView`