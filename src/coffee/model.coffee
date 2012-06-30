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
  idAttribute: 'fellow_id'
  initialize: (data...,callback) =>
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
  idAttribute: 'fellow_id'
  get_frendly_name: =>
    "#{@get('first_name')} #{@get('last_name')}"
  
  
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
  get_author_img:(callback) =>
    @author = new Model.NormalFellow
      fellow_id: @get('author_id')
    @author.fetch 
      success: =>
        @authImg=@author.attributes.img
        console.log @authImg
        callback?()
      error: =>
        #默认图片
        @authImg='http://www.gravatar.com/avatar/c53c03a085128f11f90ec17f84c88c15'
        callback?()
  is_followed_by_me:()->
    is_followed_by_me = false
    #能取到followers信息就取，取不到拉到
    if @get('fellows')
      for follow in @get('fellows')
        if follow.fellow_id is window.model.fellow.get('fellow_id')
          is_followed_by_me = true
    is_followed_by_me
    
