extends Resource
class_name Joypad

export var joypadIndex: int = 0
export var deadzone: float = 0.1


func get_left_stick() -> Vector2:
    return apply_deadzone(get_left_stick_raw(), deadzone)


func get_right_stick() -> Vector2:
    return apply_deadzone(get_right_stick_raw(), deadzone)


func get_left_stick_raw() -> Vector2:
    return get_stick_raw(JOY_ANALOG_LX, JOY_ANALOG_LY)


func get_right_stick_raw() -> Vector2:
    return get_stick_raw(JOY_ANALOG_RX, JOY_ANALOG_RY)


func get_stick_raw(axisX, axisY) -> Vector2:
    if any():
        return Vector2(Input.get_joy_axis(joypadIndex, axisX), Input.get_joy_axis(joypadIndex, axisY))
    return Vector2.ZERO


func any() -> bool:
    return Input.get_connected_joypads().size() > 0


static func apply_deadzone(v: Vector2, z: float) -> Vector2:
    var l = v.length()
    if l < z:
        return Vector2.ZERO
    else:
        return v.normalized() * ((l - z) / (1 - z))
