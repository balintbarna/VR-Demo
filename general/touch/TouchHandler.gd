extends Node
class_name TouchHandler


var touchers = {}
onready var viewport = NodeUtilities.get_child_of_type(get_parent(), Viewport)
onready var sprite = NodeUtilities.get_child_of_type(get_parent(), Sprite3D)


func _ready():
    if not sprite:
        push_error("Must have Sprite3D sibling for displaying GUI")
    if not viewport:
        push_error("Must have viewport sibling which renders GUI")


func _process(delta):
    if len(touchers) > 0:
        for sender in touchers:
            send_mouse_move_event(delta, sender)
    else:
        set_process(false)


func on_touch(sender, point):
    touchers[sender] = {
        "touch_index": len(touchers),
        "touch_node": point,
    }
    send_mouse_click_event(sender, true)
    set_process(true)


func on_leave(sender, _point):
    if sender in touchers:
        send_mouse_click_event(sender, false)
        touchers.erase(sender)


func send_mouse_click_event(sender, pressed):
    var event = InputEventMouseButton.new()
    event.button_index = 1
    event.pressed = pressed
    event.position = calculate_screen_coordinate_of_touch(touchers[sender]["touch_node"])
    touchers[sender]["last_pos"] = event.position
    event.global_position = event.position
    viewport.input(event)


func send_mouse_move_event(delta, sender):
    var event = InputEventMouseMotion.new()
    event.button_mask = BUTTON_MASK_LEFT
    event.position = calculate_screen_coordinate_of_touch(touchers[sender]["touch_node"])
    event.relative = event.position - touchers[sender]["last_pos"]
    if event.relative.length() == 0:
        return
    touchers[sender]["last_pos"] = event.position
    event.speed = event.relative / delta
    viewport.input(event)


func send_touch_event(sender, pressed):
    var event = InputEventScreenTouch.new()
    event.index = touchers[sender]["touch_index"]
    event.position = calculate_screen_coordinate_of_touch(touchers[sender]["touch_node"])
    touchers[sender]["last_pos"] = event.position
    event.pressed = pressed
    viewport.input(event)


func calculate_screen_coordinate_of_touch(point) -> Vector2:
    var meters_per_pixel = sprite.pixel_size
    var touch_point_in_screen_frame = sprite.to_local(point.global_transform.origin)
    var centered_pixel_coords = Vector2(touch_point_in_screen_frame.x, touch_point_in_screen_frame.y) / meters_per_pixel
    var pixel_coords = Vector2(centered_pixel_coords.x + viewport.size.x / 2, -centered_pixel_coords.y + viewport.size.y / 2)
    return pixel_coords
