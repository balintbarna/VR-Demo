tool
extends MeshInstance


# warning-ignore:UNUSED_CLASS_VARIABLE
var portal_color: Color setget set_portal_color, get_portal_color
onready var p = $MagicParticles


func set_portal_color(c: Color):
    var mesh_material = get_active_material(0) as SpatialMaterial
    mesh_material.albedo_color = Color(c.r, c.g, c.b, 0.7)
    if "portal_color" in p:
        p.portal_color = c
    else:
        push_error("property_not_found")


func get_portal_color():
    var mesh_material = get_active_material(0) as SpatialMaterial
    return mesh_material.albedo_color
