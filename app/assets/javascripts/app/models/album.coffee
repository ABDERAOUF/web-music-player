#= require spine
#= require spine/relation

class Album extends Spine.Model
  @configure "Album",
    "name",
    "release_date"

  @belongsTo "artist", "Artist"
  @hasMany "songs", "Song"

window.Album = Album