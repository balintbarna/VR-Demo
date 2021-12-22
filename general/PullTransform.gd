extends Node
class_name PullTransform


export(NodePath) var reference_path setget set_ref, get_ref
export var use_global_transform = true
export var pull_position = true
export var pull_orientation = true
export var pull_scale = true
var reference_node: Spatial
onready var parent = get_parent() as Spatial


func set_ref(value):
    reference_path = value
    update_reference()
func get_ref():
    return reference_path


func _ready():
    update_reference()
    if not parent is Spatial:
        push_error("Parent is not Spatial")


func _physics_process(_delta):
    if not parent or not reference_node:
        return
    var transform = parent.global_transform if use_global_transform else parent.transform
    var ref_tr = reference_node.global_transform if use_global_transform else reference_node.transform
    if pull_position:
        transform.origin = ref_tr.origin
    if pull_orientation or pull_scale:
        if pull_orientation and pull_scale:
            transform.basis = ref_tr.basis
        else:
            var rotation = Basis(ref_tr.basis.get_rotation_quat()) if pull_orientation else Basis(transform.basis.get_rotation_quat())
            var scale = ref_tr.basis.get_scale() if pull_scale else transform.basis.get_scale()
            transform.basis = rotation.scaled(scale)
    if use_global_transform:
        parent.global_transform = transform
    else:
        parent.transform = transform


func update_reference():
    if is_inside_tree() and reference_path:
        reference_node = get_node(reference_path) as Spatial
        if not reference_node is Spatial:
            push_error("Node at reference path is not Spatial")
