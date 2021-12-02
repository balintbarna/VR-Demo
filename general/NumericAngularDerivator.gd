extends Resource
class_name NumericAngularDerivator

var v_old = null
var t_old = null
var derived = null

func next(v):
    if v is Basis:
        var t = OS.get_ticks_usec()
        v = v.orthonormalized() # scaling should not be included in the calculation
        if v_old and t_old:
            derived = calc(v as Basis, v_old as Basis, t, t_old)
        else:
            derived = Vector3.ZERO
        v_old = v
        t_old = t
    return derived


static func calc(orientation_new: Basis, orientation_old: Basis, time_new: int, time_old: int):
    var time_elapsed = (time_new - time_old) / 1000000.0 # convert microseconds to seconds
    var orientation_new_relative_to_old = orientation_old.inverse() * orientation_new
    var axis_angle_new_relative_to_old = quat2axis_angle(Quat(orientation_new_relative_to_old))
    var angular_velocity_in_relative_frame = axis_angle_new_relative_to_old / time_elapsed
    return orientation_old * angular_velocity_in_relative_frame # axis transformed back to global frame, but retains magnitude


static func quat2axis_angle(q: Quat):
    var v = Vector3(q.x, q.y, q.z)
    var angle = 2 * atan2(v.length(), q.w)
    return v.normalized() * angle
