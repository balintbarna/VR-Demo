extends MeshInstance


onready var vp = $Viewport as Viewport


func _ready() -> void:
    var material = self.get_active_material(0) as SpatialMaterial
    if material and vp:
        material.albedo_texture = vp.get_texture()
