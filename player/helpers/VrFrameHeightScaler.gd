extends ArvrBodyManipulator
class_name VrFrameHeightScaler


func _physics_process(_delta):
    apply_height(spatial_parent)


func apply_height(target):
    var self_in_origin_frame = get_origin_frame_inverse() * self.global_transform.origin
    var target_height = self_in_origin_frame.y
    if target.has_method("set_height"):
        # warning-ignore:UNSAFE_METHOD_ACCESS
        target.set_height(target_height)
    else:
        push_error("no set_height method found")


func get_origin_frame_inverse():
    return get_origin().global_transform.inverse()
