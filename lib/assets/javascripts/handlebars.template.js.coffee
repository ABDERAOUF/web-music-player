#= require handlebars

Include =
  render: (item) ->
    throw "You must specify a template using @tmpl first" unless @constructor.tmpl
    @constructor.build() unless @constructor.templFunc
    @item = item or @item or {}
    @html @constructor.tmplFunc(@item)
    @trigger "rendered"
    Spine.trigger "rendered", @
    @

Extend =
  build: ->
    element = document.getElementById "#{@tmpl}-template"
    throw "Template ##{@tmpl}-template not found" unless element
    source = element.innerHTML
    @tmplFunc = Handlebars.compile source
    @

HandlebarsTemplate =
  extended: ->
    @extend Extend
    @include Include
    @

window.HandlebarsTemplate = HandlebarsTemplate