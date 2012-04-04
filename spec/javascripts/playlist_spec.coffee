#= require app/models/playlist

describe "Playlist", ->
  playlist = null

  beforeEach ->
    playlist = new Playlist

  it "should respond to 'currentSong", ->
    expect(playlist.currentSong).not.toBeUndefined()