extends KinematicBodyMover
class_name FreeLookKinematicMover


export var LINEAR_SPEED_MPS = 3


func _physics_process(delta: float):
    apply_movement(delta)


func apply_movement(dt: float) -> void:
    var input_vector = get_velocity_input_vector()
    if input_vector.length() > 1:
        input_vector = input_vector.normalized()
    var target_velocity = input_vector * LINEAR_SPEED_MPS
    var dx = target_velocity * dt
    kinematic_body.global_translate(dx)


func get_velocity_input_vector() -> Vector3:
    return get_forward_velocity_input_vector() + get_rightward_velocity_input_vector()


func get_forward_velocity_input_vector() -> Vector3:
    return -kinematic_body.global_transform.basis.z * Input.get_axis("movement_back", "movement_forward")


func get_rightward_velocity_input_vector() -> Vector3:
    return kinematic_body.global_transform.basis.x * Input.get_axis("movement_left", "movement_right")
