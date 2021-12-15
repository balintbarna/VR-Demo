extends ColorRect
class_name TouchRipple


var time_alive = 0


func _process(delta):
    time_alive += delta
    (material as ShaderMaterial).set_shader_param("time_alive", time_alive)
    if rect_size.y > 0:
        (material as ShaderMaterial).set_shader_param("aspect_ratio", rect_size.x / rect_size.y)
    if time_alive > 1:
        queue_free()
