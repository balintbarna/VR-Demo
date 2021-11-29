extends Node


signal loading_started
signal loading_complete


var loader: ResourceInteractiveLoader = null


func _ready():
    set_process(false)


func _process(_delta):
    var r = loader.poll()
    if r == ERR_FILE_EOF:
        _on_complete()


func get_finished():
    if loader:
        return not loader.get_resource() == null
    else:
        return true


func mark_load_started(new_loader):
    if not loader == null:
        push_error("SceneLoader still working")
    else:
        loader = new_loader
        if get_finished():
            _on_complete()
        else:
            set_process(true)
        emit_signal("loading_started")


func _on_complete():
    emit_signal("loading_complete", loader.get_resource())
    loader = null
    set_process(false)
