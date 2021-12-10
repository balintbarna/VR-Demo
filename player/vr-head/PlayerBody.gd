extends KinematicBody


onready var kinematic_handler = $KinematicHandler
onready var collision_shape = $PlayerCollision


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


func set_height(value):
    if collision_shape.shape is CapsuleShape:
        # warning-ignore:UNSAFE_CAST
        var shape = collision_shape.shape as CapsuleShape
        shape.height = value - shape.radius
        # total height of the shape will be a radius more than the target height,
        # the center of shape should be halfway of the height
        # but the top of the shape should be a radius above
        # the player (eye-level) point
        collision_shape.translation.y = -value / 2.0 + shape.radius / 2.0
    else:
        push_error("WRONG SHAPE")
