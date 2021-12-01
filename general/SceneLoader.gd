extends Node


signal loading_started
signal loading_complete


var loader: ResourceInteractiveLoader = null
var stage = 0 setget ,get_stage
var stage_count = 0 setget ,get_stage_count
var thread: Thread


func _ready():
    set_process(false)


func _process(_delta):
    if is_finished():
        set_process(false)
        _on_complete()


func get_stage():
    return stage


func get_stage_count():
    return stage_count


func is_loading():
    if thread:
        return thread.is_alive()
    return false


func is_finished():
    if not is_loading():
        if get_scene():
            return true
    return false


func get_scene():
    if loader:
        return loader.get_resource()
    else:
        return null


func start_loading(new_loader):
    if loader == null:
        loader = new_loader
        if is_finished():
            _on_complete()
        else:
            thread = Thread.new()
            var __ = thread.start(self, "blocking_load", Thread.PRIORITY_LOW)
            set_process(true)
        emit_signal("loading_started")
    else:
        push_error("SceneLoader still working")


func blocking_load(_userdata):
    if loader:
        var status = OK
        while status == OK:
            status = loader.poll()
            stage = loader.get_stage()
            stage_count = loader.get_stage_count()


func _on_complete():
    var scene = get_scene()
    loader = null
    thread.wait_to_finish()
    thread = null
    emit_signal("loading_complete", scene)
