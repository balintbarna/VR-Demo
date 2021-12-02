extends Spatial


onready var loading_text = $LoadingText
onready var portal = $ContinuePortal


var next_scene = null


func scene_loaded(scene):
    next_scene = scene
    Globals.get_origin().reset_to_parent()
    loading_text.visible = false
    var __ = portal.connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body: Node):
    if body is KinematicBody:
        _on_continue()


func _on_continue():
    if not OK == get_tree().change_scene_to(next_scene):
        push_error("CHANGING TO LOADED SCENE FAILED")
