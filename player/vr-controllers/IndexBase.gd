extends Spatial


onready var trigger_point = $TriggerPoint
onready var index_area = $Index


func _on_index_pointing():
    index_area.translation = Vector3.ZERO


func _on_index_rest():
    index_area.translation = trigger_point.translation
