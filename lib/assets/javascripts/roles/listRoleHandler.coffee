#= require jquery
#= require spine

#= require iscroll

class ListRoleHandler extends RoleHandler
  initRole: ($element) ->
    @scroller = @create($element) if $element.children().length
    $element.bind "rendered", =>
      @scroller = @create($element) unless @scroller
      @scroller.refresh()

  create: ($element) ->
    @scroller = new iScroll($element.children().length)

window.ListRoleHandler = ListRoleHandler