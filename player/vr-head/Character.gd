extends KinematicBody


export var orientation_guesser: Resource
export var kinematic_handler: Resource


func _physics_process(delta: float):
    (orientation_guesser as VrCharacterOrientationGuesser).process(delta, self)
    (kinematic_handler as KinematicBodyMover).process(delta, self)


func swap_mover():
    if kinematic_handler is FreeLookKinematicMover:
        kinematic_handler = FlatWorldPhysicsKinematicMover.new()
    else:
        kinematic_handler = FreeLookKinematicMover.new()
