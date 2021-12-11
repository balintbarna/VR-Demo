extends "res://addons/gut/test.gd"


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
