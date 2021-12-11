extends Spatial


onready var target = $Target
onready var joy = $SimpleJoyDesk/SimpleJoy
onready var dial = $DialDesk/Dial


func _physics_process(_delta):
    target.rotation.z = joy.angle
    target.rotation.y = dial.angle
