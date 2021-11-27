extends Spatial


onready var reflection_portal = $World/ReflectionPortal
onready var reflection_probe = $World/ReflectionProbe
onready var locomotion_swap_portal = $World/LocomotionPortal


func _ready() -> void:
    reflection_portal.connect("body_entered", self, "_reflection_portal_activated")
    locomotion_swap_portal.connect("body_entered", self, "_locomotion_swap_portal_activated")


func _reflection_portal_activated(body: Node):
    if body is KinematicBody:
        reflection_probe.update_mode = ReflectionProbe.UPDATE_ONCE
        Globals.origin.reset_to_parent()


func _locomotion_swap_portal_activated(body: Node):
    if body is KinematicBody:
        if body.has_method("swap_mover"):
            # warning-ignore:UNSAFE_METHOD_ACCESS
            body.swap_mover()
            Globals.origin.reset_to_parent()
        else:
            push_error("method_not_found")
