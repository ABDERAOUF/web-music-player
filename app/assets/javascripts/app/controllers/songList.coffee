#= require jquery
#= require spine

#= require handlebars.template

class SongList extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "songs"

window.SongList = SongList