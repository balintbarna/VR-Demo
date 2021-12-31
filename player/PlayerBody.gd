extends KinematicBody


export(NodePath) var neck_point_path
onready var vr_origin = NodeUtilities.get_child_of_type(self, ArvrOriginWithReferences)
onready var neck = get_node(neck_point_path) as Spatial
onready var mover = $Mover
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
    if mover is FreeLookMover:
        puller.reference_path = puller.get_path_to(vr_origin.hmd)
    else:
        puller.reference_path = puller.get_path_to(neck)


func pick_new_mover_based_on_current():
    if mover is FreeLookMover:
        return FlatWorldPhysicsKinematicMover.new()
    else:
        return FreeLookMover.new()
