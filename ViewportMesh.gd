extends MeshInstance


func _ready() -> void:
    var material = self.get_active_material(0) as SpatialMaterial
    var vp = $Viewport as Viewport
    if material and vp:
        material.albedo_texture = vp.get_texture()
