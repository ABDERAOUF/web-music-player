#= require jquery
#= require spine

#= require app/models/playlist

#= require handlebars.template
#= require iscroll

class LibraryLists extends Spine.Controller
  @extend HandlebarsTemplate
  @tmpl: "library-lists"

  el: "[data-el=library-lists-page]"

  events:
    "click [data-el=artists-button]": "goToArtists"
    "click [data-el=albums-button]": "goToAlbums"
    "click [data-el=now-playing-button]":"goToNowPlaying"

  constructor: ->
    super

    @render()

    new Spine.Manager(
      new ArtistList(playlist: @playlist),
      new AlbumList(playlist: @playlist),
      new SongList(playlist: @playlist))

    Spine.bind "navigate.artists", @showArtists
    Spine.bind "navigate.albums", @showAlbums
    Spine.bind "navigate.songs", @showSongs

  show: (list) ->
    #@el.find("[data-list]").hide().filter("[data-list=#{list}]").show()
    @active()

  showArtists: => @show("artists")
  showAlbums: => @show("albums")
  showSongs: => @show("songs")

  goToArtists: -> @navigate("/artists")
  goToAlbums: -> @navigate("/albums")
  goToNowPlaying: -> @navigate("/now-playing")

window.LibraryLists = LibraryLists