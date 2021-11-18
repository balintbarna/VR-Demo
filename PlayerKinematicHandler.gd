extends KinematicBodyMover
class_name PlayerKinematicHandler


const SNAP_VECTOR = Vector3(0, -1, 0)
const UP_DIRECTION = Vector3(0, 1, 0)


export var GRAVITY_ACCELERATION_MPS2 = 9.81
export var NORMAL_ACCELERATION_MPS2 = 10
export var SPRINT_ACCELERATION_MPS2 = 20
export var NORMAL_MAX_SPEED_MPS = 3
export var SPRINT_MAX_SPEED_MPS = 5
export var CUTOFF_VELOCITY_MPS = 0.3
export var DAMPING_COEFFICIENT_NSPM = 150
export var AIR_THICKNESS = 0.3 # affects in-air damping
export var JUMP_SPEED = 50
# export var MOUSE_SENSITIVITY = 0.5
# export var JOYPAD_SENSITIVITY = 2
# export var JOYPAD_DEADZONE = 0.15
# export var MOUSE_SENSITIVITY_SCROLL_WHEEL = 0.08
export var MASS = 70


var max_speed = NORMAL_MAX_SPEED_MPS
var acceleration = NORMAL_ACCELERATION_MPS2
export var rotation_speed = 2*PI
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
    calculate_sprint()
    apply_dampening(delta, body)
    accelerate_from_inputs(delta, origin, body)
    var vertical = velocity.y
    velocity.y = 0
    if velocity.length() > max_speed:
        velocity = velocity.normalized() * max_speed
    velocity.y = vertical - GRAVITY_ACCELERATION_MPS2 * delta
    velocity = body.move_and_slide_with_snap(velocity, SNAP_VECTOR, UP_DIRECTION, stop_on_slope, max_slides, floor_max_angle, infinite_inertia)


func accelerate_from_inputs(dt: float, origin: VrOrigin, body: KinematicBody) -> void:
    if body.is_on_floor():
        var dv = acceleration * dt
        var movement_vector = get_complete_movement_vector(origin.head, origin.left)
        movement_vector.y = 0
        if movement_vector.length() > 1:
            movement_vector = movement_vector.normalized()
        velocity += movement_vector * dv
        if Input.is_action_pressed("movement_jump"):
            velocity.y = JUMP_SPEED


func apply_dampening(dt: float, body: KinematicBody):
    var speed = velocity.length()
    if speed < CUTOFF_VELOCITY_MPS:
        velocity.x = 0
        velocity.z = 0
    else:
        # F = c*v
        # F = m*a -> a = F/m
        # dV = a*dt
        var damping = DAMPING_COEFFICIENT_NSPM / MASS * dt * speed
        if not body.is_on_floor():
            damping *= AIR_THICKNESS
        if damping > speed:
            velocity = Vector3()
        else:
            velocity = velocity.normalized() * (speed - damping)


func calculate_sprint():
    var sprint = 1 if Input.is_action_pressed("movement_sprint") else 0 # TODO add VR sprinting capability by hand movement
    max_speed = NORMAL_MAX_SPEED_MPS + sprint * (SPRINT_MAX_SPEED_MPS - NORMAL_MAX_SPEED_MPS)
    acceleration = NORMAL_ACCELERATION_MPS2 + sprint * (SPRINT_ACCELERATION_MPS2 - NORMAL_ACCELERATION_MPS2)


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


func get_complete_movement_vector(head, left) -> Vector3:
    return get_movement_forward(head, left) + get_movement_right(head, left)


func get_movement_forward(head, left) -> Vector3:
    return head.get_forward_direction() * left.get_movement_vector().y


func get_movement_right(head, left) -> Vector3:
    return head.get_right_direction() * left.get_movement_vector().x


func get_player_rotation_amount(delta: float, right) -> float:
    return -right.get_movement_vector().x * delta * rotation_speed
