window.Model = {}
window.model = {}

class window.Model.NavBarItem extends Backbone.Model
  upperName: =>
    name = @get_name()
    name[0] + name[1..-1]

  get_name: =>
    @attributes.name

  is_show: =>
    @attributes.is_show

  show: =>
    @set 'is_show', true

  hide: =>
    @set 'is_show', false

  is_active: =>
    @attributes.is_active

  active: =>
    @set 'is_active', true

  inactive: =>
    @set 'is_active', false

class window.Model.Fellow extends Backbone.Model
  urlRoot: '/fellow/'
  idAttribute: 'url_token'
  initialize: (callback) =>
    @fetch
      success: =>
        $.cookie 'current_user', @attributes.fellow_id
        $.cookie 'first_name', @attributes.first_name
        $.cookie 'last_name', @attributes.last_name
        callback?()
      error: =>
        console.log 'error'
        
class window.Model.NormalFellow extends Backbone.Model
  urlRoot: '/fellow/'
  idAttribute: 'url_token'
  
  
# TODO: use session for auth
class window.Model.Offer extends Backbone.Model
  idAttribute: 'offer_id'
  urlRoot: '/offer'

  # getter
  get_friendly_time: =>
    date = new Date parseInt(@attributes.created + '000')
    "#{date.getFullYear()}-#{date.getMonth() + 1}-#{date.getDate()}"
  get_fullname: =>
    "#{@attributes.author_first_name} #{@attributes.author_last_name}"
