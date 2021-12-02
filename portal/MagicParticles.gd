tool
extends Particles


var portal_color: Color setget set_portal_color, get_portal_color


func set_portal_color(c: Color):
    var material = draw_pass_1.surface_get_material(0) as SpatialMaterial
    material.albedo_color = c


func get_portal_color():
    var material = draw_pass_1.surface_get_material(0) as SpatialMaterial
    return material.albedo_color
