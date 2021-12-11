extends Spatial


onready var target = $TargetRoot/Target
onready var joy = $SimpleJoyDesk/SimpleJoy
onready var dial = $DialDesk/Dial
onready var displacer = $DisplacerDesk/LinearJoy3DoF
onready var scaler = $ScalerDesk/LinearArm


func _physics_process(_delta):
    target.rotation.z = joy.angle
    target.rotation.y = dial.angle
    target.translation = displacer.displacement * 10
    target.scale = Vector3.ONE * (1 + scaler.value * 2)
