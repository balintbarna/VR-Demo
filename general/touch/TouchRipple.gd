extends ColorRect
class_name  TouchRipple


func _init():
    color = Color.gray
    rect_size = Vector2.ONE


func _process(delta):
    rect_size += 3 * delta * rect_size
    if rect_size.length() > 15:
        queue_free()
