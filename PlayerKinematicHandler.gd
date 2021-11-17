extends KinematicBodyMover
class_name PlayerKinematicHandler


const SNAP_VECTOR = Vector3(0, -1, 0)
const UP_DIRECTION = Vector3(0, 1, 0)


export var movement_speed = 1.5
export var rotation_speed = 2*PI
export var gravity_acceleration = 9.8
export var stop_on_slope = true
export var max_slides = 4
export var floor_max_angle = 0.785398
export var infinite_inertia = false


var velocity = Vector3()


func process(delta: float, body: KinematicBody):
    var origin = Globals.origin as VrOrigin
    apply_rotation_and_fix_offset(delta, origin)
    apply_movement(delta, origin, body)
    follow_body_with_camera(origin, body)


func follow_body_with_camera(origin: VrOrigin, body: KinematicBody) -> void:
    var offset = body.global_transform.origin - origin.head.global_transform.origin
    body.translation = Vector3()
    origin.global_translate(offset)


func apply_movement(delta: float, origin: VrOrigin, body) -> void:
    velocity = velocity + get_complete_movement_vector(delta, origin.head, origin.left)
    var vertical = velocity.y
    velocity.y = 0
    if velocity.length() > movement_speed:
        velocity = velocity.normalized() * movement_speed
    velocity.y = vertical
    velocity = body.move_and_slide_with_snap(velocity, SNAP_VECTOR, UP_DIRECTION, stop_on_slope, max_slides, floor_max_angle, infinite_inertia)

    velocity.y = velocity.y - gravity_acceleration * delta
    velocity = body.move_and_slide_with_snap(velocity, SNAP_VECTOR, UP_DIRECTION, stop_on_slope, max_slides, floor_max_angle, infinite_inertia)


func get_complete_movement_vector(delta: float, head, left) -> Vector3:
    return get_movement_forward(delta, head, left) + get_movement_right(delta, head, left)


func get_movement_forward(delta: float, head, left) -> Vector3:
    return head.get_forward_direction() * left.get_movement_vector().y * delta * movement_speed


func get_movement_right(delta: float, head, left) -> Vector3:
    return head.get_right_direction() * left.get_movement_vector().x * delta * movement_speed


func apply_rotation_and_fix_offset(delta: float, origin) -> void:
    var offset_from_rotation = apply_rotation_and_calculate_offset(delta, origin)
    origin.global_translate(-offset_from_rotation)


func apply_rotation_and_calculate_offset(delta: float, origin) -> Vector3:
    var old = origin.head.global_transform.origin
    apply_rotation(delta, origin)
    var new = origin.head.global_transform.origin
    return new - old


func apply_rotation(delta: float, origin) -> void:
    origin.rotate_y(get_player_rotation_amount(delta, origin.right))


func get_player_rotation_amount(delta: float, right) -> float:
    return -right.get_movement_vector().x * delta * rotation_speed
