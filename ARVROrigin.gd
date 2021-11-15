extends ARVROrigin


const MOVEMENT_SPEED = 3
const ROTATION_SPEED = 2*PI
const ROTATION_VECTOR = Vector3(0, -1, 0)


onready var left = $LeftController
onready var right = $RightController
onready var head = $HeadCamera


var freecam = true


func _ready() -> void:
    pass # Replace with function body.


func _physics_process(delta: float) -> void:
    apply_rotation(delta)
    apply_movement(delta)


func apply_movement(delta: float) -> void:
    if freecam:
        global_translate(get_complete_movement_vector(delta))
    else:
        pass


func apply_rotation(delta: float) -> void:
    global_rotate(ROTATION_VECTOR, get_player_rotation_amount(delta))


func get_complete_movement_vector(delta: float) -> Vector3:
    return get_movement_forward(delta) + get_movement_right(delta)


func get_movement_forward(delta: float) -> Vector3:
    return head.get_forward_direction() * left.get_movement_vector().x * delta * MOVEMENT_SPEED


func get_movement_right(delta: float) -> Vector3:
    return head.get_right_direction() * left.get_movement_vector().y * delta * MOVEMENT_SPEED


func get_player_rotation_amount(delta: float) -> float:
    return right.get_movement_vector().y * delta * ROTATION_SPEED


func get_origin() -> ARVROrigin:
    return self
