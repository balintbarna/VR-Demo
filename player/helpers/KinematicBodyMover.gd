extends Spatial
class_name KinematicBodyMover


onready var kinematic_body = get_parent() as KinematicBody
func _ready():
    if not kinematic_body is KinematicBody:
        push_error("KinematicBodyMover parent is not KinematicBody")
