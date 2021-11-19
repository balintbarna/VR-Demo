extends MeshInstance


func set_color(c: Color):
    var mesh_material = get_active_material(0) as SpatialMaterial
    mesh_material.albedo_color = Color(c.r, c.g, c.b, 0.04)
    mesh_material.emission = c
    var p = $MagicParticles
    if p.has_method("set_color"):
        p.set_color(c)
    else:
        push_error("method_not_found")
