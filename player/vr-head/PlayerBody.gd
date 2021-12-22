extends KinematicBody


onready var kinematic_handler = $KinematicHandler

func _physics_process(_delta):
    if very_low_below_ground_level():
        reset_to_parent()


func reset_to_parent():
    transform = Transform()


func very_low_below_ground_level():
    return translation.y < -50


func swap_mover():
    var new_node = pick_new_mover_based_on_current()
    kinematic_handler.queue_free()
    kinematic_handler = new_node
    call_deferred("add_child", kinematic_handler)


func pick_new_mover_based_on_current():
    if kinematic_handler is FreeLookKinematicMover:
        return FlatWorldPhysicsKinematicMover.new()
    else:
        return FreeLookKinematicMover.new()
