extends Spatial


onready var trigger_point = $TriggerPoint
onready var index_area = $Index
onready var controller = get_parent() as VrController


func _on_index_pointing():
    index_area.translation = Vector3.ZERO


func _on_index_rest():
    index_area.translation = trigger_point.translation


func _on_touching_area(area):
    if controller.is_pointing():
        if "touch_handler" in area:
            area.touch_handler.on_touch(self, index_area)


func _on_leaving_area(area):
    if "touch_handler" in area:
        area.touch_handler.on_leave(self, index_area)
