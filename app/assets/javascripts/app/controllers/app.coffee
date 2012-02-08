#= require jquery
#= require spine
#= require spine/route

#= require app/controllers/artistList

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
    new ArtistList
    #new AlbumList
    #new SongList

    Artist.fetch()

window.App = App