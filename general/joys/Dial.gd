tool
extends Spatial


export(float) var angle setget set_angle, get_angle
onready var joy_body = $JoyBody

func set_angle(value):
    angle = value
    joy_body.rotation = Vector3(0, value, 0)


func get_angle():
    return joy_body.rotation.y
