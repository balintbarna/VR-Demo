extends Node
class_name KinematicBodyMover


export(NodePath) var orientation_reference_node_path
onready var orientation_reference_node = get_node(orientation_reference_node_path) as Spatial
onready var kinematic_body = get_parent() as KinematicBody
func _ready():
    if not kinematic_body is KinematicBody:
        push_error("KinematicBodyMover parent is not KinematicBody")
    if not orientation_reference_node is Spatial:
        push_error("Orientation reference node is not spatial")
