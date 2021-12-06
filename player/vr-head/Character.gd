extends KinematicBody


export var orientation_guesser: Resource
export var scaling_fixer: Resource
export var kinematic_handler: Resource
onready var collision_shape = $CharacterCollision


func _physics_process(delta: float):
    (orientation_guesser as VrCharacterOrientationGuesser).process(delta, self)
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
        shape.height = value - 2*shape.radius
        collision_shape.translation.y = -value / 2.0
    else:
        push_error("WRONG SHAPE")
