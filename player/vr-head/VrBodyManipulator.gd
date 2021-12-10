extends Node
class_name VrBodyManipulator


onready var body = get_parent() as Spatial
func _ready():
    if not body is Spatial:
        push_error("VrBodyManipulator parent is not Spatial")
