$ ->
  if $.cookie 'current_user'
    window.model.fellow = new Model.Fellow
      fellow_id: $.cookie('current_user')
  Backbone.emulateJSON = true
  window.view.layout = new View.Layout
  window.router = new Router
  Backbone.history.start()

  window.reset = (callback) ->
    $.post '/api/v2/reset', ->
      callback?()
