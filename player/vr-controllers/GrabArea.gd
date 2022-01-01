extends Area


signal releasing


onready var hand_grab_point = $GrabPoint as Spatial


func try_grab():
    for body in get_overlapping_bodies():
        var feature = NodeUtilities.get_child_of_type(body, GrabHandler)
        if feature:
            var grabbed = feature.on_grab(self, hand_grab_point)
            if grabbed:
                var __ = connect("releasing", feature, "on_release")
                return


func release():
    emit_signal("releasing", self, hand_grab_point)
