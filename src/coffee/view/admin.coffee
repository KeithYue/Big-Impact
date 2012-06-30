class window.View.Admin extends Backbone.View
  el: '#content'
  template: Template.admin
  initialize: =>
    # TODO: refactoring this: add validation
    @render()
    @checkbox = @$ 'input[type=checkbox]'
    @is_admin = @checkbox.is ':checked'
  render: =>
    @$el.html @template()

  # urls
  adminUrl: '/admin'
  fellowUrl: '/fellow'

  # events
  events:
    'click button[type=submit]': 'submit'
    'change input[type=checkbox]': 'toggleAdmin'

  toggleAdmin: (event) =>
    @is_admin = not @is_admin

  submit: (event) =>
    event.preventDefault()
    event.stopPropagation()
    data =
      email: @$('input[name=email]').val()
      first_name: @$('input[name=first_name]').val()
      last_name: @$('input[name=last_name]').val()
    url = '/api/v2'
    if @is_admin
      url += @adminUrl
    else
      url += @fellowUrl
    $.ajax
      url: url
      type: "POST"
      data:
        json: JSON.stringify(data)
      success: (data, status, xhr) =>
        if @is_admin
          view.message.success 'Admin account created!'
        else
          view.message.success 'Fellow account created!'
      error: (xhr, status, error) =>
        view.message.error JSON.parse(xhr.responseText).error
