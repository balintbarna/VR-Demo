extends Spatial
class_name RigidBodyGrabHandler


var old_mode: int
var old_collision_layer: int
var old_collision_mask: int
var grab_point: Spatial
var hand_point: Spatial
var velocity_calculator: NumericDerivator
var angular_velocity_calculator: NumericAngularDerivator
onready var body = get_parent() as RigidBody


func _physics_process(_delta):
    if is_grabbed():
        if body:
            if not grab_point:
                push_error("NO GRAB POINT FOUND")
            var offset = calculate_grab_point_offset()
            var body_scale = body.scale
            body.global_transform = hand_point.global_transform * offset
            body.scale = body_scale
            velocity_calculator.next(body.global_transform.origin)
            angular_velocity_calculator.next(body.global_transform.basis)
        else:
            push_error("BODY NOT SET")


func calculate_grab_point_offset():
    var body_frame = body.global_transform.orthonormalized() 
    var point_frame = grab_point.global_transform.orthonormalized()
    var point_in_body_frame = body_frame.inverse() * point_frame
    return point_in_body_frame.inverse()


func on_grab(point):
    if not is_grabbed():
        old_mode = body.mode
        old_collision_layer = body.collision_layer
        old_collision_mask = body.collision_mask
    body.mode = RigidBody.MODE_STATIC
    body.collision_layer = 0
    # body.collision_mask = 0
    hand_point = point
    velocity_calculator = NumericDerivator.new()
    angular_velocity_calculator = NumericAngularDerivator.new()
    find_closest_grab_point()
    set_physics_process(true)
    return true


func find_closest_grab_point():
    grab_point = null
    var lowest_distance = INF
    var closest_point = null
    var grab_points = get_grab_points()
    if grab_points:
        for point in grab_points:
            var dist = (point.global_transform.origin - hand_point.global_transform.origin).length()
            if dist < lowest_distance:
                lowest_distance = dist
                closest_point = point
        if lowest_distance == INF:
            closest_point = null
        grab_point = closest_point
    if not grab_point:
        grab_point = body


func on_release(sender, point):
    sender.disconnect("releasing", self, "on_release")
    if hand_point == point:
        body.mode = old_mode
        body.collision_layer = old_collision_layer
        body.collision_mask = old_collision_mask
        # warning-ignore:UNSAFE_PROPERTY_ACCESS
        body.linear_velocity = velocity_calculator.derived
        # warning-ignore:UNSAFE_PROPERTY_ACCESS
        body.angular_velocity = angular_velocity_calculator.derived
        hand_point = null
        set_physics_process(false)
        return true
    return false


func is_grabbed():
    return not not hand_point


func get_grab_points():
    var arr = get_children()
    return arr if len(arr) else [self]
