#= require spine
#= require spine/ajax
#= require spine/relation

class Album extends Spine.Model
  @configure "Album",
    "name",
    "sort_name",
    "rating",
    "release_date",
    "cover_url"

  @extend Spine.Model.Ajax

  @belongsTo "artist", "Artist"
  @hasMany "songs", "Song"

  flatten: ->
    artist = @artist()

    id: @id
    name: @name
    sort_name: @sort_name
    rating: @rating,
    release_date: @release_date
    cover_url: @cover_url
    artist: artist.name

window.Album = Album