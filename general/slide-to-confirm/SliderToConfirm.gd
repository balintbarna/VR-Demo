extends HSlider


onready var occluder = $TouchOccluder


func _process(delta):
    if value < 0:
        set_process(false)
    value -= 150 * delta


func _input(event):
    if event is InputEventMouseButton:
        if event.pressed:
            set_process(false)
        else:
            set_process(true)


func _on_HSlider_value_changed(value: float) -> void:
    occluder.anchor_left = value / 100
    occluder.margin_left = 100 - value
