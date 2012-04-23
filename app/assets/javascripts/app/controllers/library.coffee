#= require jquery
#= require spine

#= require app/models/playlist

#= require handlebars.template
#= require iscroll

class Library extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "library"

  el: "[data-el=library-page]"

  constructor: ->
    super

    @render()

    new Spine.Manager(
      new ArtistList(playlist: @playlist),
      new AlbumList(playlist: @playlist),
      new SongList(playlist: @playlist))

window.Library = Library