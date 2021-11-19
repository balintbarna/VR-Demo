extends Area


var grabbed_body: PhysicsBody = null
var grabbed_body_closes_grab_point = Transform()


func _ready() -> void:
    register_hand_events()


func _physics_process(_delta):
    if grabbed_body:
        var held_scale = grabbed_body.scale
        grabbed_body.global_transform = global_transform
        grabbed_body.scale = held_scale


func register_hand_events():
    var hand = get_parent()
    hand.connect("grip_pressed", self, "_on_grip_pressed")


func _on_grip_pressed():
    var bodies = get_overlapping_bodies()
    for body in bodies:
        if body.has_method("get_grab_points"):
            grab_body(body)
            return


func grab_body(body):
    grabbed_body = body
    var lowest_distance = INF
    var closest_point = null
    for point in body.get_grab_points():
        var dist = (point.origin - global_transform.origin).length()
        if dist < lowest_distance:
            lowest_distance = dist
            closest_point = point
    grabbed_body_closes_grab_point = closest_point
