extends Spatial


onready var reflection_portal = $World/ReflectionPortal
onready var reflection_probe = $World/ReflectionProbe
onready var locomotion_swap_portal = $World/LocomotionPortal
onready var portal_room_portal = $World/PortalRoomPortal
onready var player = $StartingPosition/Player


func _ready() -> void:
    reflection_portal.connect("body_entered", self, "_reflection_portal_activated")
    locomotion_swap_portal.connect("body_entered", self, "_locomotion_swap_portal_activated")
    portal_room_portal.connect("body_entered", self, "_portal_room_portal_activated")


func _reflection_portal_activated(body: Node):
    if body is KinematicBody:
        reflection_probe.update_mode = ReflectionProbe.UPDATE_ONCE
        player.reset_to_parent()


func _locomotion_swap_portal_activated(body: Node):
    if body is KinematicBody:
        if body.has_method("swap_mover"):
            # warning-ignore:UNSAFE_METHOD_ACCESS
            body.swap_mover()
            player.reset_to_parent()
        else:
            push_error("method_not_found")


func _portal_room_portal_activated(body: Node):
    if body is KinematicBody:
        load_loading_room_scene()
        load_portal_room_scene()


func load_loading_room_scene():
    if not OK == get_tree().change_scene_to(SceneLibrary.get_loading_room_scene()):
        push_error("COULD NOT LOAD STARTING SCENE")


func load_portal_room_scene():
    SceneLoader.start_loading(SceneLibrary.get_portal_room_scene())
