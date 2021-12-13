extends Node
class_name TouchHandler


var touchers = {}
onready var viewport = get_node("../Viewport") as Viewport
onready var sprite = get_node("../Sprite3D") as Sprite3D


func on_touch(sender, point):
    touchers[sender] = len(touchers)
    # send_touch_event(sender, point, true)
    send_mouse_event(sender, point, true)


func on_leave(sender, point):
    if sender in touchers:
        # send_touch_event(sender, point, false)
        send_mouse_event(sender, point, false)
        touchers.erase(sender)


func send_mouse_event(_sender, point, pressed):
    var event = InputEventMouseButton.new()
    event.button_index = 1
    event.pressed = pressed
    var pos = calculate_screen_coordinate_of_touch(point)
    event.global_position = pos
    event.position = pos
    viewport.input(event)


func send_touch_event(sender, point, pressed):
    var event = InputEventScreenTouch.new()
    event.index = touchers[sender]
    event.position = calculate_screen_coordinate_of_touch(point)
    event.pressed = pressed
    viewport.input(event)


func calculate_screen_coordinate_of_touch(point) -> Vector2:
    var meters_per_pixel = sprite.pixel_size
    var touch_point_in_screen_frame = sprite.to_local(point.global_transform.origin)
    var centered_pixel_coords = Vector2(touch_point_in_screen_frame.x, touch_point_in_screen_frame.y) / meters_per_pixel
    var pixel_coords = Vector2(centered_pixel_coords.x + viewport.size.x / 2, -centered_pixel_coords.y + viewport.size.y / 2)
    return pixel_coords
