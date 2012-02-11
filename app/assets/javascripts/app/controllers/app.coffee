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

    window.onbeforeunload = ->
      # TODO: Get from resource
      if Spine.Ajax.pending
        '''Data is still being sent to the server;
           you may lose unsaved changes if you close this page.'''

    # Initialise main controllers
    artistsPage = new ArtistsPage(el: $("#artists-page"))
    albumsPage  = new AlbumsPage(el: $("#albums-page"))
    songsPage   = new SongsPage(el: $("#songs-page"))

    new Spine.Manager(artistsPage,
      albumsPage,
      songsPage)

    artistsPage.active()

    Artist.fetch()
    Album.fetch()
    Song.fetch()

window.App = App