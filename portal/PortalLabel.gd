tool
extends Label


func set_name(portal_name):
    text = portal_name


func set_color(portal_color):
    set("custom_colors/font_color", portal_color)
