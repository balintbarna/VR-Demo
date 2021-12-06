extends ARVRCamera
class_name HeadCamera


func get_right_direction() -> Vector3:
    return global_transform.basis.x.normalized()


func get_left_direction() -> Vector3:
    return -get_right_direction()


func get_up_direction() -> Vector3:
    return global_transform.basis.y.normalized()


func get_down_direction() -> Vector3:
    return -get_up_direction()


func get_backward_direction() -> Vector3:
    return global_transform.basis.z.normalized()


func get_forward_direction() -> Vector3:
    return -get_backward_direction()


func is_upright() -> bool:
    var up_in_origin_frame = transform.basis.y
    return up_in_origin_frame.y > 0
