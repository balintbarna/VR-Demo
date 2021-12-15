extends Node


signal new_origin_set
signal new_mapping_set


var origin: VrOrigin = null setget set_origin, get_origin
var mapping = null setget set_mapping, get_mapping


func set_mapping(value):
    mapping = value
    emit_signal("new_mapping_set")


func get_mapping():
    return mapping


func set_origin(value: VrOrigin) -> void:
    origin = value
    emit_signal("new_origin_set")


func get_origin() -> VrOrigin:
    return origin
