extends Area


func _ready():
    connect("body_entered", self, "wake_up")
    connect("body_exited", self, "let_sleep")


func wake_up(body):
    if "can_sleep" in body:
        body.can_sleep = false
        body.sleeping = false


func let_sleep(body):
    if "can_sleep" in body:
        body.can_sleep = true
