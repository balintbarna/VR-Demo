extends Spatial


export var orientation_giver_path: NodePath
export var body_scaler: Resource
onready var orientation_giver = get_node(orientation_giver_path) as Spatial
onready var feed_point = $ChestPoint/StomachPoint/GenitaliaPoint/KneeHeight/FeetHeight
onready var default_height = abs((global_transform.orthonormalized().inverse() * feed_point.global_transform.origin).y)


func _physics_process(delta):
    global_transform.basis = orientation_giver.global_transform.basis
    (body_scaler as VrBodyScaler).process(delta, self)


func set_height(value):
    scale.y = value / default_height