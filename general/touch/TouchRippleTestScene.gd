extends Control


var ripple_scene = preload("res://general/touch/TouchRipple.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    var timer = Timer.new()
    timer.autostart = true
    timer.wait_time = 1
    timer.connect("timeout", self, "_on_timer")
    add_child(timer)


func _on_timer():
    var rect = ripple_scene.instance()
    rect.set_position(Vector2(rand_range(0,200), rand_range(0, 200)))
    rect.set_size(Vector2(100, 100))
    add_child(rect)
