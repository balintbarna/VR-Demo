extends VBoxContainer


func _process(_delta: float) -> void:
    var head = get_hmd() as HeadCamera
    if head:
        display_transform(head)


func display_transform(head):
    var tr = head.translation
    var rd = head.rotation_degrees
    var posarr = ["%2.3f" % tr.x, "%2.3f" % tr.y, "%2.3f" % tr.z]
    var rotarr = ["%2.3f" % rd.x, "%2.3f" % rd.y, "%2.3f" % rd.z]
    var pl = $TransformContainer/Position as Label
    pl.text = "Position\nX:  {}\nY:  {}\nZ: {}".format(posarr, "{}")
    var rl = $TransformContainer/Rotation as Label
    rl.text = "Rotation\nX:  {}\nY:  {}\nZ: {}".format(rotarr, "{}")


func get_hmd() -> HeadCamera:
    var origin = Globals.origin
    if origin:
        return origin.head
    return null
