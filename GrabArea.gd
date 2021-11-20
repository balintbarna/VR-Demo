extends Area


onready var hand_grab_point = $GrabPoint as Spatial


var grabbed_body: PhysicsBody = null
var grab_point_offset = Transform()


func _ready() -> void:
    register_hand_events()


func _physics_process(_delta):
    if grabbed_body:
        var held_scale = grabbed_body.scale
        grabbed_body.global_transform = hand_grab_point.global_transform * grab_point_offset
        grabbed_body.scale = held_scale


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
    grabbed_body = null


func grab_body(body):
    grabbed_body = body
    var lowest_distance = INF
    var closest_point = null
    for point in body.get_grab_points():
        var dist = (point.origin - hand_grab_point.global_transform.origin).length()
        if dist < lowest_distance:
            lowest_distance = dist
            closest_point = point
    if lowest_distance == INF:
        closest_point = Transform()
    var body_frame = body.global_transform.orthonormalized() 
    var grab_point_body_frame = body_frame.inverse() * closest_point.orthonormalized()
    grab_point_offset = grab_point_body_frame.inverse()
