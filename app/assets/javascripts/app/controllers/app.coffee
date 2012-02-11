#= require jquery
#= require spine
#= require spine/manager
#= require spine/route

#= require_directory .
#= require_directory ../models

class App extends Spine.Controller
  constructor: ->
    super

    #Spine.bind "rendered", (c) -> c.el.initRoles()
    #@el.initRoles()

    # window.onbeforeunload = ->
    #   # TODO: Get from resource
    #   if Spine.Ajax.pending
    #     '''Data is still being sent to the server;
    #        you may lose unsaved changes if you close this page.'''

    # Initialise main controllers
    new Spine.Manager(new ArtistsPage(el: $("#artists-page")),
      new AlbumsPage(el: $("#albums-page")),
      new SongsPage(el: $("#songs-page")))

    Spine.trigger("show:artists")

    # Artist.fetch()
    # Album.fetch()
    # Song.fetch()

    # TEMP: Temp data, bootstrapped
    Artist.refresh([
      { id: 1, name: "Michael Jackson" },
      { id: 2, name: "Mumford & Sons" }
    ])
    Album.refresh([
      { id: 1, name: "Bad", artist_id: 1 },
      { id: 2, name: "Thriller", artist_id: 1 }
      { id: 3, name: "Sigh No More", artist_id: 2 }
    ])

window.App = App