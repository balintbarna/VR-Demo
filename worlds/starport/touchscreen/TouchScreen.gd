extends Area


signal get_ship_confirmed


func _on_gui_ship_confirmed():
    emit_signal("get_ship_confirmed")
