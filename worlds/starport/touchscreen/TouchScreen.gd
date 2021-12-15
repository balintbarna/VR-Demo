extends Area


signal get_ship_confirmed


# warning-ignore:UNUSED_CLASS_VARIABLE
onready var touch_handler = $TouchHandler


func _on_gui_ship_confirmed():
    emit_signal("get_ship_confirmed")
