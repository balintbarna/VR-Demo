extends Spatial


onready var animator = $AnimationPlayer


func _on_ship_requested():
    animator.play()