extends Spatial


func load_loading_room_scene():
    if not OK == get_tree().change_scene_to(SceneLibrary.get_loading_room_scene()):
        push_error("COULD NOT LOAD STARTING SCENE")


func load_golden_box_scene():
    SceneLoader.start_loading(SceneLibrary.get_gold_box_scene())


func _gold_box_portal_entered(body):
    if body is KinematicBody:
        load_loading_room_scene()
        load_golden_box_scene()


func _on_CranePortal_body_entered(body) -> void:
    if body is KinematicBody:
        load_loading_room_scene()
        load_crane_world()


func load_crane_world():
    SceneLoader.start_loading(SceneLibrary.get_crane_world_scene())
