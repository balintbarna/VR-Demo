extends RigidBody


export var grab_handler: Resource = RigidBodyGrabHandler.new()


func _ready():
    grab_handler.body = self
    grab_handler.grab_points = [$GrabPoint]


func _physics_process(delta):
    grab_handler.process(delta)
