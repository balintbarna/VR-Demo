extends Spatial

onready var joy = $JoyBody
onready var grab_feature = NodeUtilities.get_child_of_type(joy, GrabHandler)
onready var red = $Base/Red
onready var green = $Base/Green
onready var blue = $Base/Blue


func _physics_process(_delta):
    red.translation.x = joy.transform.origin.x
    green.translation.y = joy.transform.origin.y
    blue.translation.z = joy.transform.origin.z


func get_joy_displacement():
    return Vector3(
        joy.transform.origin.x / grab_feature.linear_limit.x,
        joy.transform.origin.y / grab_feature.linear_limit.y,
        joy.transform.origin.z / grab_feature.linear_limit.z
    )


func get_joy_rotation():
    var euler = grab_feature.vectorify_rotation(joy.transform.basis)
    return Vector3(
        euler.x / grab_feature.angular_limit.x,
        euler.y / grab_feature.angular_limit.y,
        euler.z / grab_feature.angular_limit.z
    )
