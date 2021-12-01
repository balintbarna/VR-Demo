extends Spatial


onready var loading_text = $LoadingText
onready var portal = $ContinuePortal


var next_scene = null


func _ready():
    remove_child(portal)


func scene_loaded(scene):
    next_scene = scene
    Globals.get_origin().reset_to_parent()
    loading_text.visible = false
    var __ = portal.connect("body_entered", self, "_on_body_entered")
    add_child(portal)


func _on_body_entered(body: Node):
    if body is KinematicBody:
        _on_continue()


func _on_continue():
    var current = get_tree().current_scene
    if OK == get_tree().change_scene_to(next_scene):
        current.queue_free()
    else:
        push_error("CHANGING TO LOADED SCENE FAILED")
