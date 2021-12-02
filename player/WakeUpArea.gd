extends Area


func _ready():
    var __ = connect("body_entered", self, "wake_up")
    __ = connect("body_exited", self, "let_sleep")


func wake_up(body):
    if "can_sleep" in body:
        body.can_sleep = false
        body.sleeping = false


func let_sleep(body):
    if "can_sleep" in body:
        body.can_sleep = true
