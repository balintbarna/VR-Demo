extends CollisionShape


func _physics_process(_delta: float) -> void:
    set_height_between_origin_and_camera()
    scale_to_camera_height()


func set_height_between_origin_and_camera() -> void:
    var head = get_vr_head()
    var position_in_origin_frame = Vector3(head.translation)
    position_in_origin_frame.y /= 2.0
    var position_in_global_frame = get_origin().global_transform * position_in_origin_frame
    global_transform.origin = position_in_global_frame


func scale_to_camera_height() -> void:
    scale.z = abs(get_vr_height()) # Z axis instead of Y because the shape is rotated around X


func get_vr_height() -> float:
    return get_vr_head().translation.y


func get_vr_head() -> HeadCamera:
    return get_origin().head


func get_origin() -> VrOrigin:
    return Globals.origin as VrOrigin
