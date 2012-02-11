#= require jquery
#= require spine

#= require handlebars.template

#= require app/models/artist

class ArtistList extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "artists"

  activate: ->
    @render()

window.ArtistList = ArtistList