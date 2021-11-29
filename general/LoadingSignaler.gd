extends Node


signal loading_started
signal loading_complete


var finished = true


func mark_load_started():
    finished = false
    emit_signal("loading_started")


func mark_load_complete(loaded_resource):
    finished = true
    emit_signal("loading_complete", loaded_resource)
