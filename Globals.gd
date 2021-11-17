extends Node


signal origin_set_signal


var origin: VrOrigin = null setget set_origin, get_origin


func set_origin(value: VrOrigin) -> void:
    origin = value
    emit_signal("origin_set_signal")


func get_origin() -> VrOrigin:
    return origin as VrOrigin
