extends VBoxContainer


func _process(_delta: float) -> void:
    var origin = Globals.origin as VrOrigin
    if origin:
        display_scale(origin)
        display_transform(origin)


func display_scale(origin):
    ($WorldScale as Label).text = "World scale: {}".format([origin.world_scale], "{}")


func display_transform(origin):
    var tr = origin.translation
    var rd = origin.rotation_degrees
    var posarr = ["%2.3f" % tr.x, "%2.3f" % tr.y, "%2.3f" % tr.z]
    var rotarr = ["%2.3f" % rd.x, "%2.3f" % rd.y, "%2.3f" % rd.z]
    ($TransformContainer/Position as Label).text = "Position\nX:  {}\nY:  {}\nZ: {}".format(posarr, "{}")
    ($TransformContainer/Rotation as Label).text = "Rotation\nX:  {}\nY:  {}\nZ: {}".format(rotarr, "{}")
