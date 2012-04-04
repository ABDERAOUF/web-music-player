#= require app/models/playlist

describe "Playlist", ->

  it "should respond to 'currentSong", ->
    expect(Playlist.currentSong).not.toBeUndefined()

  it "should be happy", ->
    expect(false).toBeFalsy()