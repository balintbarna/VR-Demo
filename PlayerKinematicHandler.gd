extends Resource
class_name PlayerKinematicHandler

const SNAP_VECTOR = Vector3(0, -1, 0)
const UP_DIRECTION = Vector3(0, 1, 0)


export var gravity_acceleration = 9.8
export var stop_on_slope = true
export var max_slides = 4
export var floor_max_angle = 0.785398
export var infinite_inertia = false


var velocity = Vector3()


func _process(delta: float, body: KinematicBody):
    velocity.y = velocity.y - gravity_acceleration * delta
    velocity = body.move_and_slide_with_snap(velocity, SNAP_VECTOR, UP_DIRECTION, stop_on_slope, max_slides, floor_max_angle, infinite_inertia)
    var offset = body.global_transform.origin - Globals.origin.head.global_transform.origin
    body.global_transform.origin = Globals.origin.head.global_transform.origin
    Globals.origin.global_translate(offset)