extends Camera


export var mouse_pitch_speed = 2*PI


func _physics_process(delta):
    if not ARVRServer.primary_interface:
        self.rotate_x(Input.get_axis("pitch_down", "pitch_up") * delta * mouse_pitch_speed)
