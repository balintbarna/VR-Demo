extends VBoxContainer


export var controller_id: int = 0


var mesh_counter = 0


func _ready():
    if Globals.origin:
        subscribe_to_controller_signals()
    else:
        Globals.connect("origin_set_signal", self, "subscribe_to_controller_signals")


func _process(delta: float) -> void:
    var controller = get_controller() as VrController
    if controller:
        $Name.text = "Name: {}".format([controller.get_name()], "{}")
        $Hand.text = "Hand: {}".format([controller.get_hand()], "{}")
        $Active.text = "Active: {}".format([controller.get_is_active()], "{}")
        $Joystick.text = "Joystick: {}".format([controller.get_joystick_id()], "{}")
        $MeshUpdate.text = "Mesh updated {} times".format([mesh_counter], "{}")


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
    $ButtonEvent.text = "Button {} {}".format([button, action], "{}")
