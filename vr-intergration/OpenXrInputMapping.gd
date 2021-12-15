extends BaseMapping
class_name OpenXrInputMapping


func _init():
    # BUTTONS --------------

    THUMBSTICK_TOUCHING = 12

    INDEX_TOUCHING = 16

    # AXES --------------

    GRIP_STRENGTH = JOY_VR_ANALOG_GRIP # [-1; 1] = [idle; pressed]
