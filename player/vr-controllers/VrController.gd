extends ARVRController
class_name VrController


signal grip_pressed
signal grip_released
signal thumb_up
signal thumb_rest
signal index_pointing
signal index_rest


const CONTROLLER_RUMBLE_FADE_SPEED = 2.0
const CONTROLLER_DEADZONE = 0.1


onready var mesh_instance: MeshInstance = $MeshInstance


var buttons = QuestButtons.new()


func _ready():
    var __ = connect("button_pressed", self, "_on_button_pressed")
    __ = connect("button_release", self, "_on_button_released")


func _input(event):
    if event is InputEventAction:
        print(str(event))


func _physics_process(delta: float) -> void:
    if rumble > 0:
        rumble -= delta * CONTROLLER_RUMBLE_FADE_SPEED
        if rumble < 0:
            rumble = 0


func _on_button_pressed(button: int):
    match button:
        buttons.GRIP:
            emit_signal("grip_pressed")
        buttons.THUMB_POINTING_UP:
            emit_signal("thumb_up")
        buttons.INDEX_POINTING:
            emit_signal("index_pointing")


func _on_button_released(button: int):
    match button:
        buttons.GRIP:
            emit_signal("grip_released")
        buttons.THUMB_POINTING_UP:
            emit_signal("thumb_rest")
        buttons.INDEX_POINTING:
            emit_signal("index_rest")


func is_pointing():
    return is_button_pressed(buttons.INDEX_POINTING)


func is_gripping():
    return is_button_pressed(buttons.GRIP)


func is_thumb_up():
    return is_button_pressed(buttons.THUMB_POINTING_UP)


func get_biaxial_analog_input_vector() -> Vector2:
    return get_trackpad_vector() + get_joystick_vector()


func get_trackpad_vector() -> Vector2:
    return Joypad.apply_deadzone(get_trackpad_vector_raw(), CONTROLLER_DEADZONE)


func get_joystick_vector() -> Vector2:
    return Joypad.apply_deadzone(get_joystick_vector_raw(), CONTROLLER_DEADZONE)


func get_trackpad_vector_raw() -> Vector2:
    var leftright = get_joystick_axis(JOY_OPENVR_TOUCHPADX) # [-1; 1]
    var backforward = get_joystick_axis(JOY_OPENVR_TOUCHPADY) # [-1; 1]
    return Vector2(leftright, backforward) # (X, Y)


func get_joystick_vector_raw() -> Vector2:
    var leftright = get_joystick_axis(4) # [-1; 1]
    var backforward = get_joystick_axis(5) # [-1; 1]
    return Vector2(leftright, backforward) # (X, Y)
