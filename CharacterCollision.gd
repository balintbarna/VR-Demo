extends CollisionShape


onready var GLOBAL_ROTATION = global_transform.basis


func _physics_process(delta: float) -> void:
    global_transform.basis = GLOBAL_ROTATION