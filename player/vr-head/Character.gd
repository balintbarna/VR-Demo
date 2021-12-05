extends KinematicBody


export var orientation_guesser: Resource
export var scaling_fixer: Resource
export var kinematic_handler: Resource
onready var collision_shape = $CharacterCollision
onready var neck = $NeckPoint
# warning-ignore:UNUSED_CLASS_VARIABLE
onready var ground_contact_node = $NeckPoint/ChestPoint/StomachPoint/GenitaliaPoint/KneeHeight/FeetHeight
onready var default_height = abs((global_transform.orthonormalized().inverse() * ground_contact_node.global_transform.origin).y)


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
    neck.scale.y = value / default_height
    if collision_shape.shape is CapsuleShape:
        # warning-ignore:UNSAFE_CAST
        var shape = collision_shape.shape as CapsuleShape
        shape.height = value - 2*shape.radius
        collision_shape.translation.y = -value / 2.0
    else:
        push_error("WRONG SHAPE")
