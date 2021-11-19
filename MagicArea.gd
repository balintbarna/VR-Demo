extends Area


func set_color(c: Color):
    var m = $MagicMesh
    if m.has_method("set_color"):
        m.set_color(c)
    else:
        push_error("method_not_found")
