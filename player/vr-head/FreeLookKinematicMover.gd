extends KinematicVrBodyMover
class_name FreeLookKinematicMover


export var LINEAR_SPEED_MPS = 3
export var ROTATION_SPEED_RPS = 2*PI


func _physics_process(delta: float):
    var origin = Globals.origin as VrOrigin
    apply_rotation_and_fix_offset(delta, origin)
    apply_movement(delta, origin)


func apply_movement(dt: float, origin: VrOrigin) -> void:
    var input_vector = get_velocity_input_vector(origin.head, origin.left)
    if input_vector.length() > 1:
        input_vector = input_vector.normalized()
    var target_velocity = input_vector * LINEAR_SPEED_MPS
    var dx = target_velocity * dt
    origin.global_translate(dx)


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


func get_velocity_input_vector(head, left) -> Vector3:
    return get_forward_velocity_input_vector(head, left) + get_rightward_velocity_input_vector(head, left)


func get_forward_velocity_input_vector(head, left) -> Vector3:
    return head.get_forward_direction() * left.get_biaxial_analog_input_vector().y


func get_rightward_velocity_input_vector(head, left) -> Vector3:
    return head.get_right_direction() * left.get_biaxial_analog_input_vector().x


func get_player_rotation_amount(delta: float, right) -> float:
    return -right.get_biaxial_analog_input_vector().x * delta * ROTATION_SPEED_RPS
