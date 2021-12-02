tool
extends Spatial


signal body_entered


export var portal_name = "Portal" setget set_portal_name, get_portal_name
export var portal_color: Color setget set_portal_color, get_portal_color


onready var collision_area: Area = $MagicArea
onready var label = $Viewport/Label


func _ready() -> void:
    var _r = collision_area.connect("body_entered", self, "_on_body_entered_area")


func _on_body_entered_area(body: Node):
    emit_signal("body_entered", body)


func set_portal_name(new_name):
    if label:
        label.portal_name = new_name


func get_portal_name():
    if label:
        return label.portal_name


func set_portal_color(color):
    if label:
        label.portal_color = color
    if collision_area:
        if collision_area.has_method("set_color"):
            # warning-ignore:UNSAFE_METHOD_ACCESS
            collision_area.set_color(color)
        else:
            push_error("method_not_found")


func get_portal_color():
    if label:
        return label.portal_color
