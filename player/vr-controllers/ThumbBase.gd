extends Spatial


onready var rest_point = $RestPoint
onready var thumb_area = $Thumb


func _on_thumb_up():
    thumb_area.translation = Vector3.ZERO


func _on_thumb_rest():
    thumb_area.translation = rest_point.translation
