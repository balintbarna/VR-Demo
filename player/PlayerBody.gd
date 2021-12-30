extends KinematicBody


onready var hmd = $VrOrigin/HeadCamera
onready var neck = $NeckPoint as Spatial
onready var mover = $KinematicHandler
var puller: PullTransform


func _physics_process(_delta):
    if very_low_below_ground_level():
        reset_to_parent()


func reset_to_parent():
    transform = Transform()


func very_low_below_ground_level():
    return translation.y < -50


func swap_mover():
    var node = pick_new_mover_based_on_current()
    mover.queue_free()
    mover = node
    mover.connect("ready", self, "on_new_mover_ready")
    puller = PullTransform.new()
    puller.pull_position = false
    puller.pull_scale = false
    mover.add_child(puller)
    call_deferred("add_child", mover)


func on_new_mover_ready():
    if mover is FreeLookKinematicMover:
        puller.reference_path = puller.get_path_to(hmd)
    else:
        puller.reference_path = puller.get_path_to(neck)


func pick_new_mover_based_on_current():
    if mover is FreeLookKinematicMover:
        return FlatWorldPhysicsKinematicMover.new()
    else:
        return FreeLookKinematicMover.new()
