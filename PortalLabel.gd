extends Control


onready var label = ($Label as Label)


func set_name(portal_name):
    label.text = portal_name


func set_color(portal_color):
    label.set("custom_colors/font_color", portal_color)
