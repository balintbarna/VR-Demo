extends Resource
class_name PlayerKinematicHandler


const ROTATION_VECTOR = Vector3(0, -1, 0)
const SNAP_VECTOR = Vector3(0, -1, 0)
const UP_DIRECTION = Vector3(0, 1, 0)


export var movement_speed = 3
export var rotation_speed = 2*PI
export var gravity_acceleration = 9.8
export var stop_on_slope = true
export var max_slides = 4
export var floor_max_angle = 0.785398
export var infinite_inertia = false


var velocity = Vector3()


func _process(delta: float, body: KinematicBody):
    var origin = Globals.origin as VrOrigin
    var offset_from_rotation = apply_rotation_and_calculate_offset(delta)
    origin.global_translate(-offset_from_rotation)
    apply_movement(delta)

    velocity.y = velocity.y - gravity_acceleration * delta
    velocity = body.move_and_slide_with_snap(velocity, SNAP_VECTOR, UP_DIRECTION, stop_on_slope, max_slides, floor_max_angle, infinite_inertia)
    var offset = body.global_transform.origin - origin.head.global_transform.origin
    body.global_transform.origin = origin.head.global_transform.origin
    origin.global_translate(offset)


func apply_movement(delta: float) -> void:
    (Globals.origin as VrOrigin).global_translate(get_complete_movement_vector(delta))


func get_complete_movement_vector(delta: float) -> Vector3:
    return get_movement_forward(delta) + get_movement_right(delta)


func get_movement_forward(delta: float) -> Vector3:
    return (Globals.origin as VrOrigin).head.get_forward_direction() * (Globals.origin as VrOrigin).left.get_movement_vector().y * delta * movement_speed


func get_movement_right(delta: float) -> Vector3:
    return (Globals.origin as VrOrigin).head.get_right_direction() * (Globals.origin as VrOrigin).left.get_movement_vector().x * delta * movement_speed


func apply_rotation_and_calculate_offset(delta: float) -> Vector3:
    var head = (Globals.origin as VrOrigin).head
    var pos = head.global_transform.origin
    apply_rotation(delta)
    return head.global_transform.origin - pos


func apply_rotation(delta: float) -> void:
    (Globals.origin as VrOrigin).global_rotate(ROTATION_VECTOR, get_player_rotation_amount(delta))


func get_player_rotation_amount(delta: float) -> float:
    return (Globals.origin as VrOrigin).right.get_movement_vector().x * delta * rotation_speed
