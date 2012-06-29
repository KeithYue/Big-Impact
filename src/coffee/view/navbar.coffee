class window.View.NavBar extends Backbone.View
  el: '#main-nav'
  events:
    'click #createOffer': 'createOffer'
  initialize: (@collection) =>
    @collection.on 'change', @render
    @render()
  template: Template.navbar
  render: =>
    template = @template
      items: @collection.models
    @$el.html template
  createOffer: =>
    view.modal.showOfferModal()
