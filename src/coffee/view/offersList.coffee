class window.View.OffersList extends Backbone.View
  template: Template.offerList
  el: '#feedsContent'
  initialize: =>
    @offers= new Collection.OfferList
    @offers.fetch
      success: =>
        @render()
    @
  render: =>
    console.log @offers.toJSON()
    @$el.html @template(
      offers: @offers.toJSON()
    )
    @
