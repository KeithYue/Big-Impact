class window.View.CreateOfferModal extends Backbone.View
  el: '#modal'
  template: Template.createOffer
  initialize: (@offers) =>
    @render()
  render: =>
    @$el.html @template()
    @$('#createOfferModal').modal('show')

  # events
  events:
    'click .save': 'saveOffer'

  saveOffer: (events) =>
    data_array = @$('form').serializeArray()
    data = {}
    for field in data_array
      data[field.name] = field.value
    data.created = new Date().valueOf().toString()[0...-3]
    data.member_first_name = $.cookie 'first_name'
    data.member_last_name = $.cookie 'last_name'
    @offers.create data,
      success: (model, response)=>
        @undelegateEvents()
        @$('#createOfferModal').modal('hide')
        #刷新页面
        window.location.reload()
      error: (model, response)=>
        console.log 'error'
    false
