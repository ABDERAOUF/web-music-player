#= require jquery
#= require spine

#= require handlebars.template

class AlbumList extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "albums"

window.AlbumList = AlbumList