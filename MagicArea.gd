extends Area


onready var m = $MagicMesh


func set_color(c: Color):
    if m.has_method("set_color"):
        m.set_color(c)
    else:
        push_error("method_not_found")
