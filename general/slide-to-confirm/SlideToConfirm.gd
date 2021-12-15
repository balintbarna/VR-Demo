extends CenterContainer


signal confirmed


func _on_HSlider_value_changed(value: float) -> void:
    if value > 99:
        emit_signal("confirmed")
