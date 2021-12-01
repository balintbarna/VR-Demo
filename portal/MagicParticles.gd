tool
extends Particles


func set_color(c: Color):
    var material = draw_pass_1.surface_get_material(0) as SpatialMaterial
    material.albedo_color = c