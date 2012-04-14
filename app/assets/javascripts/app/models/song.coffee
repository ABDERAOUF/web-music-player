#= require spine
#= require spine/ajax
#= require spine/relation

class Song extends Spine.Model
  @configure "Song",
    "name",
    "sort_name",
    "rating",
    "url"

  @extend Spine.Model.Ajax

  @belongsTo "artist", "Artist"
  @belongsTo "album", "Album"

  flatten: ->
    artist = @artist()
    album = @album()

    id: @id
    name: @name
    sort_name: @sort_name
    rating: @rating,
    album: album.name
    album_cover_url: album.cover_url
    album_release_date: album.release_date
    artist: artist.name

window.Song = Song