extends Node


var printing setget ,get_printing
func get_printing():
	return get_parent().printing

func _enter_tree() -> void:
	if get_printing():
		print("entered tree " + self.name)


func _ready() -> void:
	if get_printing():
		print("ready " + self.name)


func _process(_delta):
	if get_printing():
		print("process " + self.name)


func _physics_process(_delta):
	if get_printing():
		print("physics process " + self.name)
