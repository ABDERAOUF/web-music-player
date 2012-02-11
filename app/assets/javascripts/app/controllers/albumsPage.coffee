#= require jquery
#= require spine

#= require handlebars.template

class AlbumsPage extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "albums"

window.AlbumsPage = AlbumsPage