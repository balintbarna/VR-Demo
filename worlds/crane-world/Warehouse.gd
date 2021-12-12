extends Spatial


export var displacement_speed = 0.5
export var rotation_speed = PI/4
onready var target_root = $TargetRoot
onready var target = $TargetRoot/Target
onready var joy = $SimpleJoyDesk/SimpleJoy
onready var dial = $DialDesk/Dial
onready var displacer = $DisplacerDesk/LinearJoy3DoF
onready var scaler = $ScalerDesk/LinearArm
onready var full_joy = $Joy6DoF


func _physics_process(delta):
    target.rotation.z = joy.angle
    target.rotation.y = dial.angle
    target.translation = displacer.displacement * 10
    target.scale = Vector3.ONE * (1 + scaler.value * 2)
    apply_incremental_transformation_from_spring_joys(delta)


func apply_incremental_transformation_from_spring_joys(delta):
    target_root.translate(full_joy.get_joy_displacement() * delta * displacement_speed)
    var relative_rotations = full_joy.get_joy_rotation()
    target_root.rotate_object_local(relative_rotations.normalized(), relative_rotations.length() * delta * rotation_speed)
