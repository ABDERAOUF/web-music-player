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

    $body = $("body")
    $body.on "navigate.artists", => @showArtists()
    $body.on "navigate.albums", => @showAlbums()
    $body.on "navigate.songs", => @showSongs()

  showArtists: -> console.log("artists")
  showAlbums: -> console.log("albums")
  showSongs: -> console.log("songs")

window.LibraryLists = LibraryLists