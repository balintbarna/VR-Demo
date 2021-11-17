extends ARVRController
class_name VrController


const CONTROLLER_RUMBLE_FADE_SPEED = 2.0
const CONTROLLER_DEADZONE = 0.2


func _ready() -> void:
    pass # Replace with function body.


func _physics_process(delta: float) -> void:
    if rumble > 0:
        rumble -= delta * CONTROLLER_RUMBLE_FADE_SPEED
        if rumble < 0:
            rumble = 0


func get_movement_vector() -> Vector2:
    return get_trackpad_vector() + get_joystick_vector()


func get_trackpad_vector() -> Vector2:
    return apply_deadzone(get_trackpad_vector_raw(), CONTROLLER_DEADZONE)


func get_joystick_vector() -> Vector2:
    return apply_deadzone(get_joystick_vector_raw(), CONTROLLER_DEADZONE)


func get_trackpad_vector_raw() -> Vector2:
    var leftright = get_joystick_axis(JOY_OPENVR_TOUCHPADX) # -1 - 1
    var backforward = get_joystick_axis(JOY_OPENVR_TOUCHPADY) # -1 - 1
    return Vector2(leftright, backforward) # X - Y


func get_joystick_vector_raw() -> Vector2:
    var leftright = get_joystick_axis(4) # -1 - 1
    var backforward = get_joystick_axis(5) # -1 - 1
    return Vector2(leftright, backforward) # X - Y


func apply_deadzone(v, z) -> Vector2:
    var l = v.length()
    if l < z:
        return Vector2()
    else:
        return v.normalized() * ((l - z) / (1 - z))
