extends KinematicBody


export var kinematic_handler: Resource


func _physics_process(delta: float):
    var h = kinematic_handler as KinematicBodyMover
    h.process(delta, self)


func switch_to_freelook_mover():
    kinematic_handler = FreeLookKinematicMover.new()
