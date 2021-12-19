extends KinematicVrBodyMover
class_name FreeLookKinematicMover


export var rotator: Resource
export var LINEAR_SPEED_MPS = 3


func _ready():
    if not rotator:
        rotator = ReferenceOffsetCompensatingRotator.new()


func _physics_process(delta: float):
    var origin = Globals.origin as VrOrigin
    rotator.rotate_base_and_compensate_reference_offset(delta, origin, origin.head)
    apply_movement(delta, origin)


func apply_movement(dt: float, origin: VrOrigin) -> void:
    var input_vector = get_velocity_input_vector(origin.head, origin.left)
    if input_vector.length() > 1:
        input_vector = input_vector.normalized()
    var target_velocity = input_vector * LINEAR_SPEED_MPS
    var dx = target_velocity * dt
    origin.global_translate(dx)


func get_velocity_input_vector(head, left) -> Vector3:
    return get_forward_velocity_input_vector(head, left) + get_rightward_velocity_input_vector(head, left)


func get_forward_velocity_input_vector(head, left) -> Vector3:
    return head.get_forward_direction() * left.get_stick_vector().y


func get_rightward_velocity_input_vector(head, left) -> Vector3:
    return head.get_right_direction() * left.get_stick_vector().x
