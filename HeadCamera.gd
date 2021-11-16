extends ARVRCamera


func get_forward_direction() -> Vector3:
    return global_transform.basis.z.normalized()


func get_right_direction() -> Vector3:
    return global_transform.basis.x.normalized()


func get_origin() -> ARVROrigin:
    var parent = get_parent()
    if parent.has_method("get_origin"):
        return parent.get_origin()
    else:
        push_error("No get_origin in parent")
        return null