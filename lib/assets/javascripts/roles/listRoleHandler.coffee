#= require jquery
#= require spine

#= require iscroll

class ListRoleHandler extends RoleHandler
  initRole: ($element) ->
    @scroller = new iScroll($element[0])
    $element.bind "rendered", => @scroller.refresh()