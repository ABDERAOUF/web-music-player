#= require jquery
#= require spine

#= require handlebars.template

#= require app/models/artist

class ArtistsPage extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "artists"

  activate: ->
    @render()

window.ArtistsPage = ArtistsPage