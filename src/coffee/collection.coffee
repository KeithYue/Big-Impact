window.Collection = {}
window.collection = {}

class window.Collection.NavBar extends Backbone.Collection
  model: window.Model.NavBarItem
  initialize: (callback) =>
    @add [
      name: 'index'
    ,
      name: 'admin'
    ,
      name: 'activities'
    ,
      name: 'profile'
    ]
    callback?()

  hideAll: =>
    @all (item) =>
      item.hide()

  inactiveAll: =>
    @all (item) =>
      item.inactive()

  findItem: (name) =>
    @find (item) =>
      item.attributes.name is name

  active: (name) =>
    @inactiveAll()
    @show name
    @findItem(name).active()

  show: (name) =>
    @findItem(name).show()

  # items
  index: =>
    @hideAll()
    @active 'index'

  admin: =>
    @hideAll()
    @active 'admin'

  profile: =>
    @hideAll()
    @active 'profile'
    @show 'activities'

  activities: =>
    @hideAll()
    @active 'activities'
    @show 'profile'

class window.Collection.OfferList extends Backbone.Collection
  model: window.Model.Offer
  url: ->
    '/offers'
  initialize: (callback) =>
    @fetch
      success: =>
        callback()
      error: =>
        console.log 'error'

  comparator: (offer) =>
    return -~~offer.get 'created'

  loadMore: (callback) =>
    @fetch
      success: =>
        callback()
      error: =>
        console.log 'load more failed'
      data:
        time_stamp: @last().attributes.created
      add: true
