extends VrBodyManipulator
class_name VrFrameHeightScaler


export(NodePath) var reference_path
onready var reference_node = get_node(reference_path) as Spatial
func _ready():
    if not reference_node is Spatial:
        push_error("Reference node is not Spatial")


func _physics_process(_delta):
        var origin_frame_inversed = get_origin_frame_inverse()
        var head_in_origin_frame = origin_frame_inversed * reference_node.global_transform.origin
        var target_height = head_in_origin_frame.y
        if body.has_method("set_height"):
            # warning-ignore:UNSAFE_METHOD_ACCESS
            body.set_height(target_height)
        else:
            push_error("no set_height method found")


func get_origin_frame_inverse():
    return get_origin().global_transform.inverse()
