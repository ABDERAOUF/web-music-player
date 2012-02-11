#= require jquery
#= require spine

#= require handlebars.template

class SongsPage extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "songs"

window.SongsPage = SongsPage