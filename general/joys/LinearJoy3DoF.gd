tool
extends Spatial


export var displacement = Vector3() setget set_displacement, get_displacement
onready var joy_body = $JoyBody

func set_displacement(value):
    if joy_body:
        displacement = value
        joy_body.translation = value


func get_displacement():
    if joy_body:
        return joy_body.translation
    else:
        return displacement
