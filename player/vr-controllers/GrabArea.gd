extends Area


signal releasing


onready var hand_grab_point = $GrabPoint as Spatial


func try_grab():
    for body in get_overlapping_bodies():
        if "grab_handler" in body:
            var grabbed = body.grab_handler.on_grab(self, hand_grab_point)
            if grabbed:
                var __ = connect("releasing", body.grab_handler, "on_release")
                return


func release():
    emit_signal("releasing", self, hand_grab_point)
