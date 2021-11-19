extends Spatial


signal body_entered


export var portal_name = "Portal"
export var portal_color = Color(1, 1, 1, 1)


onready var collision_area: Area = $MagicArea


func _ready() -> void:
    var _r = collision_area.connect("body_entered", self, "_on_body_entered_area")
    set_properties(portal_name, portal_color)


func _on_body_entered_area(body: Node):
    emit_signal("body_entered", body)


func set_properties(n, c):
    var l = $PortalNameTag/Viewport/PortalLabel
    l.set_name(n)
    l.set_color(c)
    var a = $MagicArea
    if a.has_method("set_color"):
        a.set_color(c)
    else:
        push_error("method_not_found")