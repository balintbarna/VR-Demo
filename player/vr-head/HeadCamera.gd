extends ARVRCamera
class_name HeadCamera


func get_forward_direction() -> Vector3:
    return global_transform.basis.z.normalized() * -1


func get_right_direction() -> Vector3:
    return global_transform.basis.x.normalized()
