extends Panel


signal get_ship_pressed


var counter = 0
var slider_counter = 0
onready var result_label = $VBoxContainer/Result
onready var slider_result_label = $VBoxContainer/SliderResult


func _on_get_ship_button_press():
    counter+=1
    result_label.text = "button now pressed {} times".format([counter], "{}")
    emit_signal("get_ship_pressed")


func _input(event: InputEvent) -> void:
    if event is InputEventScreenTouch:
        if not event.pressed:
            var rect = TouchRipple.new()
            rect.set_position(event.position)
            add_child(rect)


func _on_ship_slider_sliding(value):
    if value > 99:
        slider_counter += 1
        slider_result_label.text = "slider activated {} times".format([slider_counter], "{}")
        emit_signal("get_ship_pressed")
