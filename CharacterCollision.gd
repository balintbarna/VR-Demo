extends CollisionShape


onready var GLOBAL_ROTATION = global_transform.basis
onready var origin: ARVROrigin = get_origin()
const ZERO_VECTOR = Vector3()

func _physics_process(_delta: float) -> void:
    reset_orientation()
    set_height_between_origin_and_camera()
    scale_to_camera_height()


func set_height_between_origin_and_camera() -> void:
    var head = get_vr_head()
    var position = Vector3(head.global_transform.origin)
    position.y = origin.global_transform.origin.y + head.translation.y / 2
    global_transform.origin = position


func reset_orientation() -> void:
    global_transform.basis = GLOBAL_ROTATION


func scale_to_camera_height() -> void:
    scale.y = abs(get_vr_height())


func get_vr_height() -> float:
    return get_vr_head().translation.y


func get_vr_head() -> ARVRCamera:
    return origin.head


func get_origin() -> ARVROrigin:
    var parent = get_parent()
    if parent.has_method("get_origin"):
        return parent.get_origin()
    else:
        push_error("No get_origin in parent")
        return null
