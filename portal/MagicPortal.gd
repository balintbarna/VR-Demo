tool
extends Spatial


signal body_entered


export var portal_name: String setget set_portal_name, get_portal_name
export var portal_color: Color setget set_portal_color, get_portal_color


onready var collision_area: Area = $MagicArea
onready var label = $Viewport/Label


func _ready() -> void:
    update_portal_name()
    update_portal_color()
    var _r = collision_area.connect("body_entered", self, "_on_body_entered_area")


func _on_body_entered_area(body: Node):
    emit_signal("body_entered", body)


func set_portal_name(new_name):
    portal_name = new_name
    update_portal_name()


func get_portal_name():
    return portal_name


func update_portal_name():
    if label:
        label.portal_name = portal_name


func set_portal_color(new_color):
    portal_color = new_color
    update_portal_color()


func get_portal_color():
    return portal_color


func update_portal_color():
    if label:
        label.portal_color = portal_color
    if collision_area:
        if "portal_color" in collision_area:
            # warning-ignore:UNSAFE_METHOD_ACCESS
            collision_area.portal_color = portal_color
        else:
            push_error("property_not_found")
