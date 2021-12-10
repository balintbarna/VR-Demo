extends Spatial
class_name JoyGrabHandler


export(Array, bool) var dof_array
var old_collision_layer: int
var grab_point: Spatial
var hand_point: Spatial
onready var body = get_parent() as Spatial


func _physics_process(_delta):
    if is_grabbed():
        if body:
            if not grab_point:
                push_error("NO GRAB POINT FOUND")
            var offset = calculate_grab_point_offset()
            var target_transform = hand_point.global_transform * offset
            var body_scale = body.scale
            body.global_transform = target_transform
            body.scale = body_scale
        else:
            push_error("BODY NOT SET")


func calculate_grab_point_offset():
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
    grab_point = Spatial.new()
    add_child(grab_point)
    grab_point.global_transform.basis = hand_point.global_transform.basis
    grab_point.global_transform.origin = body.global_transform.origin + projected_hand_vector


func on_release(sender, point):
    sender.disconnect("releasing", self, "on_release")
    if hand_point == point:
        body.collision_layer = old_collision_layer
        hand_point = null
        set_physics_process(false)
        return true
    return false


func is_grabbed():
    return not not hand_point


func get_grab_points():
    var arr = get_children()
    return arr if len(arr) else [self]
