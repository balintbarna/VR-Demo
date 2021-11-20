extends Area


onready var hand_grab_point = $GrabPoint as Spatial


var grabbed_body: PhysicsBody = null
var grabbed_body_scale: Vector3 = Vector3.ONE
var grab_point: Spatial = null
var grab_point_offset: Transform = Transform.IDENTITY
var grabbed_body_mode = RigidBody.MODE_RIGID


func _ready() -> void:
    register_hand_events()


func _physics_process(_delta):
    if grabbed_body:
        grabbed_body.global_transform = hand_grab_point.global_transform * grab_point_offset
        grabbed_body.scale = grabbed_body_scale


func register_hand_events():
    var hand = get_parent()
    hand.connect("grip_pressed", self, "_on_grip_pressed")
    hand.connect("grip_released", self, "_on_grip_released")


func _on_grip_pressed():
    var bodies = get_overlapping_bodies()
    for body in bodies:
        if body.has_method("get_grab_points"):
            grab_body(body)
            return


func _on_grip_released():
    if grabbed_body is RigidBody:
        (grabbed_body as RigidBody).mode = grabbed_body_mode
    grabbed_body = null


func grab_body(body):
    grabbed_body = body
    if grabbed_body is RigidBody:
        grabbed_body_mode = body.mode
        body.mode = RigidBody.MODE_KINEMATIC
    find_closes_grab_point(body.get_grab_points())
    calculate_grab_point_offset(body, grab_point)


func find_closes_grab_point(grab_points):
    var lowest_distance = INF
    var closest_point = null
    for point in grab_points:
        var dist = (point.global_transform.origin - hand_grab_point.global_transform.origin).length()
        if dist < lowest_distance:
            lowest_distance = dist
            closest_point = point
    if lowest_distance == INF:
        closest_point = null
    grab_point = closest_point


func calculate_grab_point_offset(body, point):
    var body_frame = body.global_transform.orthonormalized() 
    var point_frame = point.global_transform.orthonormalized()
    var point_in_body_frame = body_frame.inverse() * point_frame
    grab_point_offset = point_in_body_frame.inverse()
