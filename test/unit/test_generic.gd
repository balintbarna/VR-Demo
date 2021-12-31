extends "res://addons/gut/test.gd"


func test_types():
    var node_type = ArvrOriginWithReferences
    var node = ArvrOriginWithReferences.new()
    assert_true(node is node_type)
    node.free()
    assert_false(match_type())


func match_type():
    var node_type = ArvrOriginWithReferences
    var node = ArvrOriginWithReferences.new()
    var result = false
    match node:
        node_type:
            result = true
    node.free()
    return result


func test_string_truthy():
    var s: String
    assert_falsy(s)
    var x = null
    assert_falsy(x)
    s = ""
    assert_falsy(s)
    x = ""
    assert_falsy(x)
    s = "xyz"
    assert_truthy(s)


func assert_truthy(got):
    var x = true if got else false
    assert_true(x, "expected {} to be truthy".format([got], "{}"))


func assert_falsy(got):
    var x = true if got else false
    assert_false(x, "expected {} to be falsy".format([got], "{}"))
