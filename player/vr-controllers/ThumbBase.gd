extends Spatial


onready var rest_point = $RestPoint
onready var thumb_area = $Thumb
onready var controller = get_parent() as VrController


func _on_thumb_up():
    thumb_area.translation = Vector3.ZERO


func _on_thumb_rest():
    thumb_area.translation = rest_point.translation


func _on_touching_area(area):
    if controller.is_thumb_up():
        var feature = NodeUtilities.get_child_of_type(area, TouchHandler)
        if feature:
            feature.on_touch(self, thumb_area)


func _on_leaving_area(area):
    var feature = NodeUtilities.get_child_of_type(area, TouchHandler)
    if feature:
        feature.on_leave(self, thumb_area)
