extends VrBodyManipulator
class_name KinematicVrBodyMover


# warning-ignore:UNSAFE_CAST
onready var kinematic_body = body as KinematicBody
func _ready():
    if not kinematic_body is KinematicBody:
        push_error("KinematicVrBodyMover body is not KinematicBody")
