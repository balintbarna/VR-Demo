extends "res://addons/gut/test.gd"


func test_get_child():
    var parent = KinematicBody.new()
    var first_shape = CollisionShape.new()
    parent.add_child(first_shape)
    parent.add_child(CollisionShape.new())
    parent.add_child(CollisionShape.new())
    parent.add_child(MeshInstance.new())
    assert_eq(NodeUtilities.get_child_of_type(parent, CollisionShape), first_shape)
    assert_eq(NodeUtilities.get_children_of_type(parent, MeshInstance).size(), 1)
    assert_eq(NodeUtilities.get_children_of_type(parent, CollisionShape).size(), 3)
    parent.free()
