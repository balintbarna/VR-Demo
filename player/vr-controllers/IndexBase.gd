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
        var feature = NodeUtilities.get_child_of_type(area, TouchHandler)
        if feature:
            feature.on_touch(self, index_area)


func _on_leaving_area(area):
    var feature = NodeUtilities.get_child_of_type(area, TouchHandler)
    if feature:
        feature.on_leave(self, index_area)
