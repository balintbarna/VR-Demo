extends KinematicBody


const SNAP_VECTOR = Vector3(0, -1, 0)
const UP_DIRECTION = Vector3(0, 1, 0)
const STOP_ON_SLOPE = true
const MAX_SLDIES = 4
const FLOOR_MAX_ANGLE = 0.785398
const INFINITE_INTERTIA = false


var velocity = Vector3()

func _physics_process(_delta):
    velocity = SNAP_VECTOR
    velocity = move_and_slide_with_snap(velocity, SNAP_VECTOR, UP_DIRECTION, STOP_ON_SLOPE, MAX_SLDIES, FLOOR_MAX_ANGLE, INFINITE_INTERTIA)
    var offset = global_transform.origin - Globals.origin.head.global_transform.origin
    global_transform.origin = Globals.origin.head.global_transform.origin
    Globals.origin.global_translate(offset)
