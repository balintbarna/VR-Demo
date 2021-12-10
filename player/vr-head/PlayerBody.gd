extends KinematicBody


export var orientation_guesser: Resource
export var scaling_fixer: Resource
export var kinematic_handler: Resource
onready var collision_shape = $CharacterCollision


func _physics_process(delta: float):
    (orientation_guesser as VrBodyOrientationGuesser).process(delta, self)
    (scaling_fixer as VrBodyScaler).process(delta, self)
    (kinematic_handler as KinematicBodyMover).process(delta, self)


func swap_mover():
    if kinematic_handler is FreeLookKinematicMover:
        kinematic_handler = FlatWorldPhysicsKinematicMover.new()
    else:
        kinematic_handler = FreeLookKinematicMover.new()


func set_height(value):
    if collision_shape.shape is CapsuleShape:
        # warning-ignore:UNSAFE_CAST
        var shape = collision_shape.shape as CapsuleShape
        shape.height = value - shape.radius
        # total height of the shape will be a radius more than the target height,
        # the center of shape should be halfway of the height
        # but the top of the shape should be a radius above
        # the character (eye-level) point
        collision_shape.translation.y = -value / 2.0 + shape.radius / 2.0
    else:
        push_error("WRONG SHAPE")
