extends Resource
class_name RigidBodyGrabHandler


var body: RigidBody
var old_mode: int
var grab_point: Spatial
var hand_point: Spatial


func init(b: RigidBody):
    body = b


func process(_delta):
    if body and hand_point:
        if not grab_point:
            push_error("NO GRAB POINT FOUND")
        var offset = calculate_grab_point_offset()
        var body_scale = body.scale
        body.global_transform = hand_point.global_transform * offset
        body.scale = body_scale


func calculate_grab_point_offset():
    var body_frame = body.global_transform.orthonormalized() 
    var point_frame = grab_point.global_transform.orthonormalized()
    var point_in_body_frame = body_frame.inverse() * point_frame
    return point_in_body_frame.inverse()


func on_grab(point):
    if not hand_point:
        old_mode = body.mode
    hand_point = point
    body.mode = RigidBody.MODE_STATIC
    find_closest_grab_point()
    return true


func find_closest_grab_point():
    var lowest_distance = INF
    var closest_point = null
    for point in body.get_grab_points():
        var dist = (point.global_transform.origin - hand_point.global_transform.origin).length()
        if dist < lowest_distance:
            lowest_distance = dist
            closest_point = point
    if lowest_distance == INF:
        closest_point = null
    grab_point = closest_point


func on_release(point):
    if hand_point == point:
        body.mode = old_mode
        hand_point = null
        return true
    return false
