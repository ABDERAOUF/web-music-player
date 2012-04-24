#= require spine
#= require spine/route

class Router
  _instance = undefined
  @get: -> _instance ?= new _Router()

class _Router
  setup: ->
    Spine.Route.add
      "/artists":                    => @trigger "navigate.artists.all"
      "/albums":                     => @trigger "navigate.albums.all"
      "/albums/artist/:id": (params) => @trigger "navigate.albums.artist", params.id
      "/songs/artist/:id": (params)  => @trigger "navigate.songs.artist", params.id
      "/songs/album/:id": (params)   => @trigger "navigate.songs.album", params.id
      "/songs":                      => @trigger "navigate.songs.all"
      "/playlist":                   => @trigger "navigate.playlist"
      "/now-playing":                => @trigger "navigate.nowplaying"
      "/":                           => @trigger "navigate.nowplaying"

    Spine.Route.setup()

  trigger: (route, params...) ->
    events = route.split(".")
    prevEvent = null

    handle = (ev) ->
      fire = if prevEvent then "#{prevEvent}.#{ev}" else ev
      Spine.trigger(fire, params)
      prevEvent = fire

    handle(ev) for ev in events


window.Router = Router
