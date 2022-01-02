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
var mapping setget ,get_mapping
func get_mapping():
    return InputMapper.mapping


func _ready():
    mapping = get_mapping()
    var __ = connect("button_pressed", self, "_on_button_pressed")
    __ = connect("button_release", self, "_on_button_released")


func _physics_process(delta: float) -> void:
    if rumble > 0:
        rumble -= delta * CONTROLLER_RUMBLE_FADE_SPEED
        if rumble < 0:
            rumble = 0


func _on_button_pressed(button: int):
    match button:
        mapping.GRIP:
            emit_signal("gripping")
        mapping.THUMB_POINTING_UP:
            emit_signal("thumb_up")
        mapping.THUMBSTICK_TOUCHING, mapping.AX_TOUCHING, mapping.BY_TOUCHING:
            emit_signal("thumb_rest")
        mapping.INDEX_POINTING:
            emit_signal("index_pointing")
        mapping.INDEX_TOUCHING:
            emit_signal("index_rest")


func _on_button_released(button: int):
    match button:
        mapping.GRIP:
            emit_signal("loose")
        mapping.THUMB_POINTING_UP:
            emit_signal("thumb_rest")
        mapping.THUMBSTICK_TOUCHING, mapping.AX_TOUCHING, mapping.BY_TOUCHING:
            emit_signal("thumb_up")
        mapping.INDEX_POINTING:
            emit_signal("index_rest")
        mapping.INDEX_TOUCHING:
            emit_signal("index_pointing")


func is_pointing():
    if not mapping.INDEX_POINTING == JOY_INVALID_OPTION:
        return is_button_pressed(mapping.INDEX_POINTING)
    elif not mapping.INDEX_TOUCHING == JOY_INVALID_OPTION:
        return not is_button_pressed(mapping.INDEX_TOUCHING)
    else:
        push_error("NO BUTTON MAPPING FOR INDEX TOUCH")


func is_gripping():
    return is_button_pressed(mapping.GRIP)


func is_thumb_up():
    if not mapping.THUMB_POINTING_UP == JOY_INVALID_OPTION:
        return is_button_pressed(mapping.THUMB_POINTING_UP)
    elif not mapping.THUMBSTICK_TOUCHING == JOY_INVALID_OPTION:
        return not is_button_pressed(mapping.THUMBSTICK_TOUCHING) and not is_ax_by_touching()
    else:
        push_error("NO BUTTON MAPPING FOR THUMB TOUCH")


func is_ax_by_touching():
    return is_button_pressed(mapping.AX_TOUCHING) or is_button_pressed(mapping.BY_TOUCHING)
