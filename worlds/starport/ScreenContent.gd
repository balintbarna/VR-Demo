extends Panel


signal get_ship_confirmed


func _input(event: InputEvent) -> void:
    if event is InputEventScreenTouch:
        if not event.pressed:
            var rect = TouchRipple.new()
            rect.set_position(event.position)
            add_child(rect)


func _on_ship_slider_confirmed():
    emit_signal("get_ship_pressed")
