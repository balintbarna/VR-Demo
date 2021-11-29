extends Spatial


onready var label = $LoadingText/Viewport/Label


func scene_loaded(scene):
    label.text = "Loading finished. Enter portal"
