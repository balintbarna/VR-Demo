extends Control


func set_label(portal_name):
    ($Label as Label).text = portal_name


func set_color(portal_color):
    ($Label as Label).set("custom_colors/font_color", portal_color)
