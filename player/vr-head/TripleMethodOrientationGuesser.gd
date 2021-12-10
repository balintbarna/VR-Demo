extends VrBodyOrientationGuesser
class_name TripleMethodOrientationGuesser


func _physics_process(_delta):
    var old_scale = body.scale
    body.global_transform.basis = get_compound_frame(body.global_transform.origin)
    body.scale = old_scale


func get_compound_frame(reference_body_global_position: Vector3):
    var flattened_direction_in_global_frame = get_compound_direction(reference_body_global_position)
    var rotation = ExtraMath.get_vectors_rotation(Vector3.FORWARD, flattened_direction_in_global_frame)
    return Basis(rotation.normalized(), rotation.length())


func get_compound_direction(reference_body_global_position: Vector3):
    var head = get_head()
    var compound = get_hands_displacement_vector(reference_body_global_position) + get_hand_pair_forward_direction()
    if head.is_upright():
        compound += head.get_forward_direction()
    var compound_direction_in_origin_frame = get_origin_frame().inverse() * compound
    compound_direction_in_origin_frame.y = 0 # flatten
    var flattened_direction_in_global_frame = get_origin_frame() * compound_direction_in_origin_frame
    return flattened_direction_in_global_frame.normalized()


func get_hand_pair_forward_direction():
    # calculates the forward direction
    # from hands relative position to each other,
    # the right direction is the vector pointing from left hand to right,
    # the up direction is the up direction of vr origin
    var up_of_vr_origin_in_global = get_origin().global_transform.basis.y
    var left_global = get_left_hand().global_transform.origin
    var right_global = get_right_hand().global_transform.origin
    var left_to_right_vector_in_global = right_global - left_global
    return left_to_right_vector_in_global.rotated(up_of_vr_origin_in_global, PI/2)


func get_hands_displacement_vector(reference_body_global_position: Vector3):
    var left_global = get_left_hand().global_transform.origin
    var right_global = get_right_hand().global_transform.origin
    return left_global - reference_body_global_position + right_global - reference_body_global_position


func get_origin_frame():
    return get_origin().global_transform.basis


func get_right_hand():
    return get_origin().right


func get_left_hand():
    return get_origin().left


func get_head():
    return get_origin().head


func get_origin():
    return Globals.origin

