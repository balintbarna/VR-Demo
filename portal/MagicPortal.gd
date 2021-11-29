extends Spatial


signal body_entered


export var portal_name = "Portal" setget set_name, get_name
export var portal_color = Color(1, 1, 1, 1) setget set_color, get_color


onready var collision_area: Area = $MagicArea
onready var label = $Viewport/Label


func _ready() -> void:
    var _r = collision_area.connect("body_entered", self, "_on_body_entered_area")
    update_name()
    update_color()


func _on_body_entered_area(body: Node):
    emit_signal("body_entered", body)


func set_name(name):
    portal_name = name
    update_name()


func get_name():
    return portal_name


func set_color(color):
    portal_color = color
    update_color()


func get_color():
    return portal_color


func update_name():
    if label:
        label.set_name(portal_name)


func update_color():
    if label:
        label.set_color(portal_color)
    if collision_area:
        if collision_area.has_method("set_color"):
            # warning-ignore:UNSAFE_METHOD_ACCESS
            collision_area.set_color(portal_color)
        else:
            push_error("method_not_found")
