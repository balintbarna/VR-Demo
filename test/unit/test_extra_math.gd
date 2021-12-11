extends "res://addons/gut/test.gd"


var vecs = []
var mats = []


func before_all():
    for __ in range(50):
        vecs.append(Vector3(
            rand_range(-5, 5),
            rand_range(-5, 5),
            rand_range(-5, 5)
        ))
    for v in vecs:
        mats.append(Basis(v.normalized(), v.length()))

func test_get_vectors_rotation():
    var from = vecs[randi() % 50]
    var to = vecs[randi() % 50]
    var rot = ExtraMath.get_vectors_rotation(from, to)
    var to_calculated = from.rotated(rot.normalized(), rot.length())
    var to_calculated_with_basis = Basis(rot.normalized(), rot.length()) * from
    assert_vecs_almost_eq(to_calculated.normalized(), to.normalized(), ExtraMath.EPSILON)
    assert_vecs_almost_eq(to_calculated_with_basis.normalized(), to.normalized(), ExtraMath.EPSILON)


func assert_vecs_almost_eq(got, expected, max_err):
    var passing = (got-expected).length() < max_err
    assert_true(passing, "got {}, expected {}".format([got, expected], "{}"))
