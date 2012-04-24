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

    Spine.bind "navigate.artists", => @show("artists")
    Spine.bind "navigate.albums", => @show("albums")
    Spine.bind "navigate.songs", => @show("songs")

  show: (list) ->
    @el.find("[data-list]").hide().filter("[data-list=#{list}]").show()
    @active()

window.LibraryLists = LibraryLists