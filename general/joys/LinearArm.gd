tool
extends Spatial


export var value = 0.0 setget set_value, get_value
onready var joy_body = $JoyBody
onready var handler = $JoyBody/JoyGrabHandler

func set_value(v):
    if joy_body:
        value = v
        joy_body.translation.z = -v*handler.displacement_limit


func get_value():
    if joy_body:
        return -joy_body.translation.z/handler.displacement_limit
    else:
        return value
