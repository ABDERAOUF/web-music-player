#= require jquery
#= require spine

#= require handlebars.template

class ArtistList extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "artist"

window.ArtistList = ArtistList