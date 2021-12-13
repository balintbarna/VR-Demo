extends Panel


signal get_ship_pressed


var counter = 0
onready var result_label = $VBoxContainer/Result


func _on_get_ship_button_press():
    counter+=1
    result_label.text = "button now pressed {} times".format([counter], "{}")
    emit_signal("get_ship_pressed")


func _input(event: InputEvent) -> void:
    var e = event as InputEventScreenTouch
    if e and not e.pressed:
        var rect = TouchRipple.new()
        rect.set_position(e.position)
        add_child(rect)
