tool
extends Area


var portal_color: Color setget set_portal_color, get_portal_color
onready var m = $MagicMesh


func set_portal_color(c: Color):
    if "portal_color" in m:
        m.portal_color = c
    else:
        push_error("property_not_found")


func get_portal_color():
    return m.portal_color
