extends Spatial


onready var room = $World/Room


func _ready() -> void:
    var __ = LoadingSignaler.connect("loading_complete", self, "_on_loading_done")


func _on_loading_done(resource):
    room.scene_loaded(resource)
