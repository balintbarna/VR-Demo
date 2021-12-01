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
    if finished():
        _on_complete()


func get_stage():
    return stage


func get_stage_count():
    return stage_count


func finished():
    if loader:
        return not loader.get_resource() == null
    else:
        return true


func get_scene():
    if loader:
        return loader.get_resource()
    else:
        return null


func start_loading(new_loader):
    if not loader == null:
        push_error("SceneLoader still working")
    else:
        loader = new_loader
        if finished():
            _on_complete()
        else:
            thread = Thread.new()
            var __ = thread.start(self, "blocking_load", Thread.PRIORITY_LOW)
            set_process(true)
        emit_signal("loading_started")


func blocking_load(_userdata):
    if loader:
        var loading = true
        while loading:
            loading = loader.poll() == OK
            stage = loader.get_stage()
            stage_count = loader.get_stage_count()


func _on_complete():
    emit_signal("loading_complete", get_scene())
    loader = null
    thread = null
    set_process(false)
