extends KinematicBody


export var kinematic_handler: Resource


func _physics_process(delta: float):
    var h = kinematic_handler as KinematicBodyMover
    h.process(delta, self)


func swap_mover():
    if kinematic_handler is FreeLookKinematicMover:
        kinematic_handler = FlatWorldPhysicsKinematicMover.new()
    else:
        kinematic_handler = FreeLookKinematicMover.new()
