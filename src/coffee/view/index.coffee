class window.View.Index extends Backbone.View
  el: '#content'
  template: Template.index
  initialize: =>
    # TODO: refactoring this: add validation
    # dom
    @render()
    @checkbox = @$ 'input[type=checkbox]'
    @is_admin = @checkbox.is ':checked'
  render: =>
    @$el.html @template()


  # url
  urlRoot: '/session'

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
      email: $('input[name=email]').val()
      password: $('input[name=password]').val()
      auth: if @is_admin then '0' else '1'
    $.ajax '/api/v2' + @urlRoot,
      type: 'POST'
      data:
        json: JSON.stringify data
      success: (data, status, xhr) =>
        if @is_admin
          router.navigate 'admin', true
        else
            #建立当前用户
          window.model.fellow = new Model.Fellow =>
            router.navigate "profile/#{window.model.fellow.attributes.fellow_id}", true
        view.message.success 'Login success!'
      error: (xhr, status, error) =>
        console.log error
        view.message.error 'Email or password is not correct!'
