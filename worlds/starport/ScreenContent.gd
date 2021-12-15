extends Panel


signal get_ship_confirmed


onready var first_container = $VBoxContainer
onready var second_container = $CenterContainer


func _input(event: InputEvent) -> void:
    if event is InputEventScreenTouch:
        if not event.pressed:
            var rect = preload("res://general/touch/TouchRipple.tscn").instance()
            rect.set_position(event.position)
            add_child(rect)


func _on_ship_slider_confirmed():
    first_container.visible = false
    second_container.visible = true
    emit_signal("get_ship_confirmed")
