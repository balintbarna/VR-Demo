extends RigidBody


onready var grab_point = $GrabPoint as Spatial


func get_grab_points():
    return [grab_point.global_transform]
