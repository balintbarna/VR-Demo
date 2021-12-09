extends Area


func wake_up(body):
    if "can_sleep" in body:
        body.can_sleep = false
        body.sleeping = false


func let_sleep(body):
    if "can_sleep" in body:
        body.can_sleep = true
