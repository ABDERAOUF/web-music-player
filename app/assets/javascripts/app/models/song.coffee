#= require spine
#= require spine/ajax
#= require spine/relation

class Song extends Spine.Model
  @configure "Song",
    "name",
    "sort_name",
    "rating",
    "play_count",
    "track_number",
    "src_url"

  @extend Spine.Model.Ajax

  @belongsTo "album", "Album"

  flatten: ->
    album = @album()

    id: @id
    name: @name
    sort_name: @sort_name
    rating: @rating,
    album: album.name
    album_cover_url: album.cover_url
    album_year: album.year
    artist: album.artist().name

window.Song = Song