extends Spatial


func _process(_delta):
    global_transform.basis = Globals.origin.global_transform.basis
