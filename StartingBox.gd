extends Spatial


onready var magicportal = $MagicPortal
onready var reflection_probe: ReflectionProbe = $ReflectionProbe


func _ready() -> void:
    magicportal.connect("body_entered", self, "_on_body_entered_area")


func _on_body_entered_area(body: Node):
    if body is KinematicBody:
        reflection_probe.update_mode = ReflectionProbe.UPDATE_ONCE
        Globals.origin.reset_to_parent()