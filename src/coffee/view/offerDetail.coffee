class window.View.OfferDetail extends Backbone.View
  el: '#feedsContent'
  template: Template.offerDetail
  initialize: (offer_id) =>
    @offer = new Model.Offer
      offer_id: offer_id
    @offer.fetch
      success: =>
        @render()
      error: =>
        console.log 'error'
      data: =>
        offer_id: offer_id
  render: =>
    @$el.html @template(@offer.toJSON())
