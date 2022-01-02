extends Node


var printing = false
func _enter_tree() -> void:
	if printing:
		print("entered tree " + self.name)


func _ready() -> void:
	if printing:
		print("ready " + self.name)


func _process(_delta):
	if printing:
		print("process " + self.name)

var a = 100
func _physics_process(_delta):
	if printing:
		print("physics process " + self.name)
	if a == 0:
		printing = true
		var node = Node.new()
		node.name = "Bla"
		node.set_script($Child.get_script())
		self.add_child(node)
	a -= 1
