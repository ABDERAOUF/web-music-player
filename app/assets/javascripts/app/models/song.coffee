#= require spine
#= require spine/relation

class Song extends Spine.Model
  @configure "Song",
    "name",
    "sort_name",
    "rating",
    "url"

  @belongsTo "artist", "Artist"
  @belongsTo "album", "Album"

window.Song = Song