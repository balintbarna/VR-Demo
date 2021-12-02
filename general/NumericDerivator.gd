extends Resource
class_name NumericDerivator

var v_old = null
var t_old = null
var derived = null

func next(v):
    var t = OS.get_ticks_usec()
    if v_old and t_old:
        var t_elapsed = (t - t_old) / 1000000.0
        var v_diff = v - v_old
        derived = v_diff / t_elapsed
    else:
        derived = v * 0
    v_old = v
    t_old = t
    return derived
