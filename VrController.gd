extends ARVRController
class_name VrController


const CONTROLLER_RUMBLE_FADE_SPEED = 2.0
const CONTROLLER_DEADZONE = 0.1


onready var mesh_instance: MeshInstance = $MeshInstance


func _ready():
    var _r = connect("mesh_updated", self, "_set_controller_mesh")
    _set_controller_mesh()


func _physics_process(delta: float) -> void:
    if rumble > 0:
        rumble -= delta * CONTROLLER_RUMBLE_FADE_SPEED
        if rumble < 0:
            rumble = 0


func _set_controller_mesh():
    var mesh = get_mesh()
    if(mesh):
        mesh_instance.set_mesh(mesh)


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
