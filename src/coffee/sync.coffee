Backbone.original_sync = Backbone.sync
Backbone.sync = (method, model, options) ->
  options.url = '/api/v2' + model.url()
  options.data = if options.data? then _.clone(options.data) else {}
  data =
    json: if model instanceof Backbone.Collection then {} else JSON.stringify model.toJSON()
  _.extend data.json, options.data
  options.data = data
  Backbone.original_sync method, model, options
