#= require handlebars

#= require app/models/artist
#= require app/models/album
#= require app/models/song

Handlebars.registerHelper "artist_page_title", -> "Artists"

Handlebars.registerHelper "all_albums_item", ->
  albumCount = Album.count()
  songCount = Song.count()

  "<li class=\"show-all\">All Albums<span class=\"count\">#{albumCount} Albums, #{songCount} Songs</span></li>"