#= require handlebars

#= require app/models/artist
#= require app/models/album
#= require app/models/song

Handlebars.registerHelper "artist_page_title", -> "Artists"

Handlebars.registerHelper "album_count", -> Album.count()
Handlebars.registerHelper "song_count", -> Song.count()

Handlebars.registerHelper "artist_album_song_count", ->
  albumCount = this.albums().all().length
  albumWord = if albumCount == 1 then "album" else "albums"

  songCount = this.songs().all().length
  songWord = if songCount == 1 then "song" else "songs"

  "#{albumCount} #{albumWord}, #{songCount} #{songWord}"

Handlebars.registerHelper "artist_album_cover_url", ->
  this.albums().first()?.cover_url