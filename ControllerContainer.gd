extends HBoxContainer


export var controller_id: int = 0


var mesh_counter = 0


func _ready():
    if Globals.origin:
        subscribe_to_controller_signals()
    else:
        var _r = Globals.connect("origin_set_signal", self, "subscribe_to_controller_signals")


func _process(_delta: float) -> void:
    var controller = get_controller() as VrController
    if controller:
        display_basics(controller)
        display_all_button_states(controller)
        display_all_axes_states(controller)
        display_transform(controller)


func display_transform(controller):
    var tr = controller.translation
    var rd = controller.rotation_degrees
    var posarr = ["%2.3f" % tr.x, "%2.3f" % tr.y, "%2.3f" % tr.z]
    var rotarr = ["%2.3f" % rd.x, "%2.3f" % rd.y, "%2.3f" % rd.z]
    $LeftContainer/TransformContainer/Position.text = "Position\nX:  {}\nY:  {}\nZ: {}".format(posarr, "{}")
    $LeftContainer/TransformContainer/Rotation.text = "Rotation\nX:  {}\nY:  {}\nZ: {}".format(rotarr, "{}")


func display_all_button_states(controller: VrController):
    var text = "All buttons:\n"
    for i in JOY_BUTTON_MAX:
        text = text + "button {}    |{}|\n".format(["%2d" % i, "X" if controller.is_button_pressed(i) else "  "], "{}")
    $RightContainer/AllButtons.text = text


func display_all_axes_states(controller: VrController):
    var text = "All axes:\n"
    for i in JOY_AXIS_MAX:
        text = text + "axis {}    {}\n".format(["%3d" % i, "%0.2f" % controller.get_joystick_axis(i)], "{}")
    $LeftContainer/AllAxes.text = text


func display_basics(controller: VrController):
    $LeftContainer/Name.text = "Name: {}".format([controller.get_name()], "{}")
    $LeftContainer/Hand.text = "Hand: {}".format([controller.get_hand()], "{}")
    $LeftContainer/Active.text = "Active: {}".format([controller.get_is_active()], "{}")
    $LeftContainer/Joystick.text = "Joystick: {}".format([controller.get_joystick_id()], "{}")
    $LeftContainer/MeshUpdate.text = "Mesh updated {} times".format([mesh_counter], "{}")


func subscribe_to_controller_signals() -> void:
    var controller = get_controller() as VrController
    controller.connect("mesh_updated", self, "_on_mesh_updated")
    controller.connect("button_pressed", self, "_on_button_pressed")
    controller.connect("button_release", self, "_on_button_released")


func get_controller() -> VrController:
    var origin = Globals.origin
    if origin:
        return (origin.left if controller_id == 1 else origin.right if controller_id == 2 else null)
    return null


func _on_mesh_updated() -> void:
    mesh_counter = mesh_counter + 1

func _on_button_pressed(button: int) -> void:
    _on_button_action(button, "pressed")

func _on_button_released(button: int) -> void:
    _on_button_action(button, "released")

func _on_button_action(button: int, action: String) -> void:
    $LeftContainer/ButtonEvent.text = "Button {} {}".format(["%2d" % button, action], "{}")
