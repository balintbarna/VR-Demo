extends Spatial


onready var target = $Target
onready var joy = $Desk/SpringJoy1DoF


func _physics_process(delta):
    target.rotation.z = joy.angle
