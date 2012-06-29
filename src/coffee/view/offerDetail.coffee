class window.View.OfferDetail extends Backbone.View
  el: '#feedsContent'
  template: Template.offerDetail
  initialize: (offer_id) =>
    @offer = new Model.Offer
      offer_id: offer_id
    @offer.fetch
      success: =>
        @get_followers_data()
      error: =>
        console.log 'error'
      data: =>
        offer_id: offer_id
  render: =>
    @$el.html @template 
      offer: @offer.toJSON()
      followers: @followers
    
  get_followers_data: () =>
    $.ajax
      url: "/api/v2/offerfollower/#{@offer.get('offer_id')}"
      type: 'GET'
      success: (data,states,options)=>
        @followers = data
        @render()
      error: ()=>
        console.log 'error!!!'
