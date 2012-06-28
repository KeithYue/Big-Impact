class window.View.Relationship extends Backbone.View
  el: '#relationshipBlock'
  events:
    'click #follow':'follow'
    'click #unfollow':'unfollow'
  template: Template.relationship
  render: =>
    @$el.html @template
      attentions: @attentions
      followers: @followers
      I:@fellow
      followed:@followed
  initialize: (@fellow)=>
    @refresh_relation_information()
    @
  #events
  follow:=>
    $.ajax
      url: "http://localhost/api/v2/followfellow/#{@fellow.get('fellow_id')}"
      type: 'POST'
      success: =>
        @refresh_relation_information()
      error : =>
        console.log 'error!!!'
  unfollow:=>
    $.ajax
      url: "http://localhost/api/v2/followfellow/#{@fellow.get('fellow_id')}"
      type: 'DELETE'
      success: =>
        @refresh_relation_information()
      error : =>
        console.log 'error!!!'
  toggleButtonStates:=>
  #function
  is_followedByMe:=>
    is_followedByMe = false
    @followers.each (person) =>
      if person.get('fellow_id') is window.model.fellow.get('fellow_id')
        is_followedByMe = true
    is_followedByMe
  #刷新页面的入口
  refresh_relation_information: =>
    id = @fellow.get('fellow_id')
    @attentions = new Collection.FellowList "/followfellow/#{id}"
    @attentions.fetch 
      success: =>
        @render()
      error: =>
        console.log 'error!!!'
        @render()
    @followers = new Collection.FellowList "/befollowfellow/#{id}"
    @followers.fetch 
      success: =>
        @followed = @is_followedByMe()
        console.log @followed
        @render()
      error: =>
        console.log 'error!!'
        @render()
