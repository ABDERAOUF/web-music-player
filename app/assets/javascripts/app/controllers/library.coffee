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

    Spine.bind "navigate.artists", => @showArtists()
    Spine.bind "navigate.albums", => @showAlbums()
    Spine.bind "navigate.songs", => @showSongs()

  showArtists: -> @active()
  showAlbums: -> @active()
  showSongs: -> @active()

window.LibraryLists = LibraryLists