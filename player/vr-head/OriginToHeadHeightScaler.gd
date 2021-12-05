extends VrBodyScaler
class_name OriginToHeadHeightScaler


func process(_delta, body: KinematicBody):
    if "ground_contact_node" in body:
        # warning-ignore:UNSAFE_PROPERTY_ACCESS
        var ground_contact_node = body.ground_contact_node
        if ground_contact_node:
            var origin_frame_inversed = get_origin_frame().inverse()
            var head_in_origin_frame = origin_frame_inversed * body.global_transform.origin
            var target_height = head_in_origin_frame.y
            if body.has_method("set_height"):
                # warning-ignore:UNSAFE_METHOD_ACCESS
                body.set_height(target_height)
            else:
                push_error("no set_height method foudn")
    else:
        push_error("set ground contact node for scaler")


func get_origin_frame():
    return get_origin().global_transform.orthonormalized()


func get_origin():
    return Globals.origin

