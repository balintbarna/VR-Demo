extends Spatial


func _physics_process(_delta):
    global_transform.basis = Globals.origin.global_transform.basis
