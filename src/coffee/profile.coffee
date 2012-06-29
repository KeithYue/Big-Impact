class window.View.BasicProfile extends Backbone.View
  el: '#basic-profile'
  initialize: (@fellow) =>
    @render()

  # templates
  template: Template.basicProfile
  editTemplate: Template.editBasicProfile

  render: =>
    @$el.html @template(@get_fellow_data())

  # data
  get_fellow_data: =>
    @fellow.toJSON()

  # events
  events:
    'click .edit': 'edit'
    'click .save': 'save'
    'click .cancel': 'cancel'

  edit: (event) =>
    event.preventDefault()
    event.stopPropagation()
    @$el.html @editTemplate(@get_fellow_data())

  save: (event) =>
    event.preventDefault()
    event.stopPropagation()
    data_array = @$('form').serializeArray()
    data = {}
    for field in data_array
      data[field.name] = field.value
    @fellow.save data,
      success: (model, response) =>
        view.message.success 'Update success!'
        @$el.html @template(@get_fellow_data())
      error: (model, response) =>
        console.log model, response

  cancel: =>
    event.preventDefault()
    event.stopPropagation()      
    @$el.html @template(@get_fellow_data())
    
class window.View.ContactProfile extends Backbone.View
  el: '#contact-info'
  initialize: (@fellow) =>
    @render()

  # templates
  template: Template.contactProfile
  editTemplate: Template.editContactProfile

  render: =>
    @$el.html @template(@get_fellow_data())

  # data
  get_fellow_data: =>
    @fellow.toJSON()

  # events
  events:
    'click .edit': 'edit'
    'click .save': 'save'
    'click .cancel': 'cancel'

  edit: (event) =>
    event.preventDefault()
    event.stopPropagation()
    @$el.html @editTemplate(@get_fellow_data())

  save: (event) =>
    event.preventDefault()
    event.stopPropagation()
    data_array = @$('form').serializeArray()
    data = {}
    for field in data_array
      data[field.name] = field.value
    @fellow.save data,
      success: (model, response) =>
        view.message.success 'Update success!'
        @$el.html @template(@get_fellow_data())
      error: (model, response) =>
        console.log model, response

  cancel: (event)=>
    event.preventDefault()
    event.stopPropagation()    
    @$el.html @template(@get_fellow_data())
    
class window.View.OrganizationProfile extends Backbone.View
  el: '#organization-info'
  initialize: (@fellow) =>
    @render()

  # templates
  template: Template.organizationProfile
  editTemplate: Template.editOrganizationProfile

  render: =>
    @$el.html @template(@get_fellow_data())

  # data
  get_fellow_data: =>
    @fellow.toJSON()

  # events
  events:
    'click .edit': 'edit'
    'click .save': 'save'
    'click .cancel': 'cancel'

  edit: (event) =>
    event.preventDefault()
    event.stopPropagation()
    @$el.html @editTemplate(@get_fellow_data())

  save: (event) =>
    event.preventDefault()
    event.stopPropagation()
    data_array = @$('form').serializeArray()
    data = {}
    for field in data_array
      data[field.name] = field.value
    @fellow.save data,
      success: (model, response) =>
        view.message.success 'Update success!'
        @$el.html @template(@get_fellow_data())
      error: (model, response) =>
        console.log model, response

  cancel: (event)=>
    event.preventDefault()
    event.stopPropagation()    
    @$el.html @template(@get_fellow_data())
    

class window.View.Profile extends Backbone.View
  el: '#content'
  initialize: (options)=>
    if options.fellow_id
      @model = new Model.NormalFellow
        fellow_id: options.fellow_id
      @model.fetch
        success: =>
          @render()
  template: Template.profile
  render: =>
    @$el.html @template()
    @basicProfile = new View.BasicProfile @model
    @contactProfile = new View.ContactProfile @model
    @organizationProfile = new View.OrganizationProfile @model
    @relationShip = new View.Relationship @model
    @
