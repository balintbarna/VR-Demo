extends Spatial


func _portal_room_portal_activated(body: Node):
    if body is KinematicBody:
        load_loading_room_scene()
        load_portal_room_scene()


func load_loading_room_scene():
    if not OK == get_tree().change_scene_to(SceneLibrary.get_loading_room_scene()):
        push_error("COULD NOT LOAD STARTING SCENE")


func load_portal_room_scene():
    SceneLoader.start_loading(SceneLibrary.get_portal_room_scene())
