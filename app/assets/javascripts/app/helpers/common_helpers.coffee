#= require handlebars

#= require app/models/artist
#= require app/models/album
#= require app/models/song

Handlebars.registerHelper "list_divider", ->
  # TODO: Figure out if this item is the same as the first in the group
  "<li data-role=\"divider\" class=\"ui-content-list-divider\">A</li>"