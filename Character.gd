extends KinematicBody


export var kinematic_handler: Resource


func _physics_process(delta: float):
    var h = kinematic_handler as KinematicBodyMover
    h.process(delta, self)
