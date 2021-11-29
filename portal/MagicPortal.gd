extends Spatial


signal body_entered


export var portal_name = "Portal"
export var portal_color = Color(1, 1, 1, 1)


onready var collision_area: Area = $MagicArea
onready var label = $Viewport/PortalLabel


func _ready() -> void:
    var _r = collision_area.connect("body_entered", self, "_on_body_entered_area")
    set_properties(portal_name, portal_color)


func _on_body_entered_area(body: Node):
    emit_signal("body_entered", body)


func set_properties(n, c):
    label.set_name(n)
    label.set_color(c)
    if collision_area.has_method("set_color"):
        # warning-ignore:UNSAFE_METHOD_ACCESS
        collision_area.set_color(c)
    else:
        push_error("method_not_found")
