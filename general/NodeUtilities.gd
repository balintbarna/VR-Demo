extends Object
class_name NodeUtilities


# Note: passing a value for the type parameter causes a crash
static func get_child_of_type(node: Node, child_type):
    for i in range(node.get_child_count()):
        var child = node.get_child(i)
        if child is child_type:
            return child


# Note: passing a value for the type parameter causes a crash
static func get_children_of_type(node: Node, child_type):
    var list = []
    for i in range(node.get_child_count()):
        var child = node.get_child(i)
        if child is child_type:
            list.append(child)
    return list
