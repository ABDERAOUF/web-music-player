#= require jquery
#= require spine

#= require app/models/playlist

#= require handlebars.template
#= require iscroll

class LibraryLists extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "library-lists"

  el: "[data-el=library-lists-page]"

  constructor: ->
    super

    @render()

    new Spine.Manager(
      new ArtistList(playlist: @playlist),
      new AlbumList(playlist: @playlist),
      new SongList(playlist: @playlist))

window.LibraryLists = LibraryLists