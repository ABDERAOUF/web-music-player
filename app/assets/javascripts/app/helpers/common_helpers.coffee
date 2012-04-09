#= require handlebars

#= require app/models/artist
#= require app/models/album
#= require app/models/song

#Handlebars.registerHelper "artist", (prop) -> this.artist()[prop]
#Handlebars.registerHelper "album", (prop) -> this.album()[prop]

Handlebars.registerHelper "list_divider", ->
  # TODO: Figure out if this item is the same as the first in the group
  "<li data-role=\"divider\" class=\"ui-content-list-divider\">A</li>"