tool
extends CPUParticles


# warning-ignore:UNUSED_CLASS_VARIABLE
var portal_color: Color setget set_portal_color, get_portal_color


func set_portal_color(c: Color):
    ((mesh as PointMesh).material as SpatialMaterial).albedo_color = c


func get_portal_color():
    return ((mesh as PointMesh).material as SpatialMaterial).albedo_color
