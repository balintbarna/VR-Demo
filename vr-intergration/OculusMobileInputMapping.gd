extends Resource
class_name OculusMobileInputMapping

# BUTTONS --------------

const BY = JOY_OCULUS_BY
const GRIP = JOY_VR_GRIP
const MENU = JOY_OCULUS_MENU

const AX_TOUCHING = 5
const BY_TOUCHING = 6
const AX = JOY_OCULUS_AX

const THUMB_POINTING_UP = 10
const INDEX_TOUCHING = 11
const INDEX_POINTING = 12

const THUMBSTICK = JOY_VR_PAD
const TRIGGER = JOY_VR_TRIGGER

# AXES --------------

const STICK_X = JOY_OPENVR_TOUCHPADX # [-1; 1] zero in the middle
const STICK_Y = JOY_OPENVR_TOUCHPADY # [-1; 1] zero in the middle
const TRIGGER_STRENGTH = JOY_VR_ANALOG_TRIGGER # [-1; 1] = [idle; pressed]
const GRIP_STRENGTH = 3 # [-1; 1] = [idle; pressed]