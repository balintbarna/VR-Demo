extends Reference
class_name ExtraMath


static func get_vectors_rotation(from: Vector3, to: Vector3) -> Vector3:
    var dot = from.dot(to) # dot = |a|×|b|× cos(fi)
    var cross = from.cross(to) # cross = |a|×|b|× sin(fi) × n
    var length_product = from.length() * to.length()
    var cos_fi = dot / length_product
    var sin_fi = cross.length() / length_product
    var fi = atan2(sin_fi, cos_fi)
    return cross.normalized() * fi


static func basis2axis_angle(b: Basis):
    return quat2axis_angle(Quat(b))


static func quat2axis_angle(q: Quat):
    var v = Vector3(q.x, q.y, q.z)
    var angle = 2 * atan2(v.length(), q.w)
    return v.normalized() * angle
