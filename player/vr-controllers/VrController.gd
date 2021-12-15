extends ARVRController
class_name VrController


signal gripping
signal loose
signal thumb_up
signal thumb_rest
signal index_pointing
signal index_rest


const CONTROLLER_RUMBLE_FADE_SPEED = 2.0
const CONTROLLER_DEADZONE = 0.1


func _ready():
    var __ = connect("button_pressed", self, "_on_button_pressed")
    __ = connect("button_release", self, "_on_button_released")


func _physics_process(delta: float) -> void:
    if rumble > 0:
        rumble -= delta * CONTROLLER_RUMBLE_FADE_SPEED
        if rumble < 0:
            rumble = 0


func _on_button_pressed(button: int):
    match button:
        Globals.mapping.GRIP:
            emit_signal("gripping")
        Globals.mapping.THUMB_POINTING_UP:
            emit_signal("thumb_up")
        Globals.mapping.INDEX_POINTING:
            emit_signal("index_pointing")


func _on_button_released(button: int):
    match button:
        Globals.mapping.GRIP:
            emit_signal("loose")
        Globals.mapping.THUMB_POINTING_UP:
            emit_signal("thumb_rest")
        Globals.mapping.INDEX_POINTING:
            emit_signal("index_rest")


func is_pointing():
    if "INDEX_POINTING" in Globals.mapping:
        return is_button_pressed(Globals.mapping.INDEX_POINTING)
    elif "INDEX_TOUCHING" in Globals.mapping:
        return not is_button_pressed(Globals.mapping.INDEX_TOUCHING)
    else:
        push_error("NO BUTTON MAPPING FOR INDEX TOUCH")


func is_gripping():
    return is_button_pressed(Globals.mapping.GRIP)


func is_thumb_up():
    if "THUMB_POINTING_UP" in Globals.mapping:
        return is_button_pressed(Globals.mapping.THUMB_POINTING_UP)
    elif "THUMBSTICK_TOUCHING" in Globals.mapping:
        return not is_button_pressed(Globals.mapping.THUMBSTICK_TOUCHING) and not is_ax_by_touching()


func is_ax_by_touching():
    return is_button_pressed(Globals.mapping.AX_TOUCHING) or is_button_pressed(Globals.mapping.BY_TOUCHING)


func get_stick_vector() -> Vector2:
    return Joypad.apply_deadzone(get_stick_vector_raw(), CONTROLLER_DEADZONE)


func get_stick_vector_raw() -> Vector2:
    var leftright = get_joystick_axis(Globals.mapping.STICK_X) # [-1; 1]
    var backforward = get_joystick_axis(Globals.mapping.STICK_Y) # [-1; 1]
    return Vector2(leftright, backforward) # (X, Y)
