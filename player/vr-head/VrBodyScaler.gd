extends Node
class_name VrBodyScaler


onready var body = get_parent() as Spatial
func _ready():
    if not body is Spatial:
        push_error("VrBodyScaler parent is not spatial")
