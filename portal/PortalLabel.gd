tool
extends Label


# warning-ignore:UNUSED_CLASS_VARIABLE
var portal_name: String setget set_portal_name, get_portal_name
# warning-ignore:UNUSED_CLASS_VARIABLE
var portal_color: Color setget set_portal_color, get_portal_color


func set_portal_name(new_name):
    text = new_name


func get_portal_name():
    return text


func set_portal_color(new_color):
    set("custom_colors/font_color", new_color)


func get_portal_color():
    return get("custom_colors/font_color")
