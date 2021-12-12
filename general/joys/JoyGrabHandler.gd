extends Spatial
class_name JoyGrabHandler

# Set a rotation sequence for the Euler angles calculation.
# Empty String means disabled, in which case the calculation uses axis-angle vectors, which are 'sequence-less'.
# Enable for joys that 'feel' better with sequentially applied rotations, such as a flight stick that rotates around its own Y axis.
# Disable for 'sequence-less' dual axis rotation, such as controller joystick.
export var euler_sequence_order = ""
export var linear_limit = Vector3()
export var angular_limit = Vector3()
export var spring = false
var old_collision_layer: int
var grab_point: Spatial
var hand_point: Spatial
onready var body = get_parent() as Spatial
# warning-ignore:UNSAFE_CAST
onready var ref_frame_node = body.get_parent() as Spatial


func _physics_process(_delta):
    if is_grabbed():
        if body:
            if not grab_point:
                push_error("NO GRAB POINT FOUND")
            var body_in_hand_frame = calculate_body_in_grab_frame()
            var body_in_global_frame = hand_point.global_transform * body_in_hand_frame
            var ref_frame = ref_frame_node.global_transform.orthonormalized()
            var body_in_ref_frame = ref_frame.inverse() * body_in_global_frame
            # var processed_body_in_ref_frame = block_axes_and_apply_limits(body_in_ref_frame)
            var processed_body_in_ref_frame = limit_axes(body_in_ref_frame)
            var processed_body_in_global_frame = ref_frame * processed_body_in_ref_frame
            var body_scale = body.scale
            body.global_transform = processed_body_in_global_frame
            body.scale = body_scale
            var diff_to_limit_ratio = get_diff_to_limit_ratio()
            buzz_controller(pow(diff_to_limit_ratio, 4))
            if diff_to_limit_ratio > 1:
                on_release(null, hand_point)
        else:
            push_error("BODY NOT SET")


func get_diff_to_limit_ratio() -> float:
    var diff_transform = hand_point.global_transform.inverse() * grab_point.global_transform
    var displacement_ratio = diff_transform.origin.length() / 0.1
    var rotation_ratio = ExtraMath.basis2axis_angle(diff_transform.basis).length() / (PI/2)
    return max(displacement_ratio, rotation_ratio)


func limit_axes(t: Transform) -> Transform:
    var origin = limit_either_axes(t.origin, linear_limit)
    var basis = limit_angular_axes(t.basis)
    return Transform(basis, origin)


func limit_angular_axes(b: Basis) -> Basis:
    var rot_xyz = vectorify_rotation(b)
    var limited = limit_either_axes(rot_xyz, angular_limit)
    return basify_xyz_rotation(limited)


func limit_either_axes(v: Vector3, limits: Vector3) -> Vector3:
    var x = v.x if limits.x > abs(v.x) else limits.x * sign(v.x)
    var y = v.y if limits.y > abs(v.y) else limits.y * sign(v.y)
    var z = v.z if limits.z > abs(v.z) else limits.z * sign(v.z)
    return Vector3(x, y, z)


# func block_axes_and_apply_limits(t: Transform):
#     var origin = block_axes_and_limit_displacement(t.origin)
#     var basis = block_axes_and_limit_rotation(t.basis)
#     return Transform(basis, origin)


# func block_axes_and_limit_displacement(v: Vector3):
#     var blocked = block_xyz(v, x_linear_enabled, y_linear_enabled, z_linear_enabled)
#     return limit_vector_length(blocked, displacement_limit)


# func block_axes_and_limit_rotation(b: Basis):
#     var rot_xyz = vectorify_rotation(b)
#     var blocked = block_xyz(rot_xyz, x_angular_enabled, y_angular_enabled, z_angular_enabled)
#     var blocked_and_limited = limit_vector_length(blocked, angle_limit)
#     return basify_xyz_rotation(blocked_and_limited)


func basify_xyz_rotation(v: Vector3):
    if euler_sequence_order:
        return ExtraMath.euler2basis(v, euler_sequence_order)
    else:
        return Basis(v.normalized(), v.length())


func vectorify_rotation(b: Basis) -> Vector3:
    if euler_sequence_order:
        return ExtraMath.basis2euler(b, euler_sequence_order)
    else:
        return ExtraMath.basis2axis_angle(b)


# func limit_vector_length(vec: Vector3, limit: float):
#     if vec.length() > limit:
#         return limit * vec.normalized()
#     else:
#         return vec


# func block_xyz(v: Vector3, x_enable: bool, y_enable: bool, z_enable: bool):
#     return Vector3(
#         v.x if x_enable else 0.0,
#         v.y if y_enable else 0.0,
#         v.z if z_enable else 0.0
#     )


func calculate_body_in_grab_frame():
    var body_frame = body.global_transform.orthonormalized() 
    var point_frame = grab_point.global_transform.orthonormalized()
    var point_in_body_frame = body_frame.inverse() * point_frame
    return point_in_body_frame.inverse()


func on_grab(point):
    if not is_grabbed():
        old_collision_layer = body.collision_layer
    body.collision_layer = 0
    hand_point = point
    calculate_grab_point()
    set_physics_process(true)
    return true


func calculate_grab_point():
    var direction_vector = (global_transform.origin - body.global_transform.origin).normalized()
    var hand_vector = hand_point.global_transform.origin - body.global_transform.origin
    var dot = hand_vector.dot(direction_vector) # dot = |a|×|b|× cos(fi)
    var projected_hand_vector = dot * direction_vector
    if projected_hand_vector.length() == 0:
        projected_hand_vector = hand_vector
    grab_point = Spatial.new()
    add_child(grab_point)
    grab_point.global_transform.basis = hand_point.global_transform.basis
    grab_point.global_transform.origin = body.global_transform.origin + projected_hand_vector


func on_release(sender, point):
    if sender:
        sender.disconnect("releasing", self, "on_release")
    if hand_point == point:
        if spring:
            body.transform = Transform.IDENTITY
        body.collision_layer = old_collision_layer
        hand_point = null
        set_physics_process(false)
        return true
    return false


func buzz_controller(value):
    var controller = hand_point.get_parent().get_parent()
    if controller is VrController:
        controller.rumble = value
    else:
        push_error("COULD NOT GET CONTROLLER NODE")


func is_grabbed():
    return not not hand_point
