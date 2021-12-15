extends HSlider


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


func _on_HSlider_gui_input(event: InputEvent) -> void:
    pass
	# event.
