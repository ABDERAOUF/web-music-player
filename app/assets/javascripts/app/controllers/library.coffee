#= require jquery
#= require spine

#= require handlebars.template
#= require iscroll

class Library extends Spine.Controller
  @extend HandlebarsTemplate
  @templ: "library"

  el: "[data-el=library-page]"

  constructor: ->
    super

    new Spine.Manager(
      new ArtistList(playlist: @playlist),
      new AlbumList(playlist: @playlist),
      new SongList(playlist: @playlist))