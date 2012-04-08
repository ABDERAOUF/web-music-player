#= require spine
#= require spine/relation

class Album extends Spine.Model
  @configure "Album",
    "name",
    "sort_name",
    "release_date",
    "cover_url"

  @belongsTo "artist", "Artist"
  @hasMany "songs", "Song"

window.Album = Album