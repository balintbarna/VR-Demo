extends ARVROrigin
class_name VrOrigin

# variables used elsewhere in the system
# warning-ignore:UNUSED_CLASS_VARIABLE
onready var left: VrController = $LeftController
# warning-ignore:UNUSED_CLASS_VARIABLE
onready var right: VrController = $RightController
# warning-ignore:UNUSED_CLASS_VARIABLE
onready var head: HeadCamera = $HeadCamera


func _ready() -> void:
    Globals.origin = self


func _physics_process(_delta):
    if translation.y < -50:
        translation = Vector3()
