class RoleHandler extends Spine.Module
  initRole: ->

class RoleCollection extends Spine.Controller
  el: "body"

  constructor: ->
    super
    @roles = {}
    @el.data "role-collection", @

  add: (roleName, handler) ->
    @roles[roleName] = handler
    this

  remove: (roleName) ->
    delete @roles[roleName]
    this

  initRole: ($element) ->
    role = $element.data "role"
    initialised = $element.data "role-initialized"
    roleHandler = @roles[role]

    return this unless !initialised
    throw new Error("No role was specified on the element") unless role
    throw new Error("Role [#{role}] does not exist") unless roleHandler

    roleHandler.initRole $element
    $element.data "role-initialized", true
    this

  initRoles: ($element) ->
    $element.find("[data-role]").each((i, item) =>
        @initRole $(item)
    )
    this

window.RoleHandler = RoleHandler
window.RoleCollection = RoleCollection

$::initRoles = ->
    roleCollection = $("body").data("role-collection");
    roleCollection.initRoles($(this));