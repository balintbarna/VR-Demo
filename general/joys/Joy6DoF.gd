extends Spatial

onready var joy = $JoyBody
onready var red = $Base/Red
onready var green = $Base/Green
onready var blue = $Base/Blue


func _physics_process(_delta):
    red.translation.x = joy.transform.origin.x
    green.translation.y = joy.transform.origin.y
    blue.translation.z = joy.transform.origin.z


func get_joy_displacement():
    return Vector3(
        joy.transform.origin.x / joy.grab_handler.linear_limit.x,
        joy.transform.origin.y / joy.grab_handler.linear_limit.y,
        joy.transform.origin.z / joy.grab_handler.linear_limit.z
    )


func get_joy_rotation():
    var euler = joy.grab_handler.vectorify_rotation(joy.transform.basis)
    return Vector3(
        euler.x / joy.grab_handler.angular_limit.x,
        euler.y / joy.grab_handler.angular_limit.y,
        euler.z / joy.grab_handler.angular_limit.z
    )
