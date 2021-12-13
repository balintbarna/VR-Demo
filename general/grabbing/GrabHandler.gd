extends Spatial
class_name GrabHandler


func on_grab(_sender, _point) -> bool:
    return false


func on_release(_sender, _point) -> bool:
    return false


func is_grabbed() -> bool:
    return false
