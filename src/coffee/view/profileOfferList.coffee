class window.View.ProfileOfferList extends Backbone.View
  template: Template.profileOfferList
  initialize: (data)=>
    @get_offers_data(data)
  render: =>
    console.log 'profile offer list is rendering'
    console.log @offers
    @$el.html @template
      offers: @offers
  #jobs
  get_offers_data: (data)=>
    @offers = window.collection.offerlist = new Collection.OfferList({url: data.url}, =>
      @offers.each (offer)=>
        #添加follow与本人的关系
        offer.set
          is_followed_by_me: offer.is_followed_by_me()
        ,
          silent:true
        offer.get_author_img =>
          @render()
    )
    @offers.on 'remove', (offer, offers) =>
      offer.destroy
        success: =>
          @render()
          view.message.success 'Delete offer success!'
        error: =>
          console.log 'remove failed'
    @offers.on 'change', (events) =>
      console.log @offers.length
      @offers.fetch
        success: =>
          @render()
          console.log @offers.models, @offers.length
          view.message.success 'Create offer success!'    
  # events
  events:
    'click button.create': 'createOffer'
    'click button.close': 'removeOffer'
    'click a.more': 'loadMore'
    'click .unfollow': 'unfollow'
    'click .follow': 'follow'
  unfollow: (event) =>
    offer = @$(event.currentTarget).closest('.item')
    $.ajax
      url: "/api/v2/followoffer/#{offer.data('id')}"
      type: 'DELETE'
      success:(data,states,options) =>
        view.message.success 'unfollow this offer success'
        @get_offers_data()
  follow: (event) =>
    offer = @$(event.currentTarget).closest('.item')
    $.ajax
      url: "/api/v2/followoffer/#{offer.data('id')}"
      type: 'POST'
      success:(data,states,options) =>
        view.message.success 'follow this offer success'
        @get_offers_data()              
  createOffer: (event) =>
    view.modal.showOfferModal @offers
    @get_offers_data() 
    false

  removeOffer: (event) =>
    $offer = @$(event.currentTarget).closest('.item')
    @offers.remove @offers.get($offer.data('id'))

  loadMore: (event) =>
    @offers.loadMore()
    false
