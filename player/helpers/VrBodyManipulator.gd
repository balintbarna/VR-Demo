extends Node
class_name VrBodyManipulator


export(NodePath) var origin_path
onready var origin_node = get_node(origin_path) as VrOrigin
onready var body = get_parent() as Spatial
func _ready():
    if not body is Spatial:
        push_error("VrBodyManipulator parent is not Spatial")
    if not origin_node is VrOrigin:
        push_error("VrOrigin is not at path")


func get_right_hand():
    return get_origin().right


func get_left_hand():
    return get_origin().left


func get_head():
    return get_origin().head


func get_origin():
    return origin_node
