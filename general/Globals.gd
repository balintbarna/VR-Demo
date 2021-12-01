extends Node


signal new_origin_set


var origin: VrOrigin = null setget set_origin, get_origin


func set_origin(value: VrOrigin) -> void:
    origin = value
    emit_signal("new_origin_set")


func get_origin() -> VrOrigin:
    return origin
