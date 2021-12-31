extends Spatial


onready var feet_point = $ChestPoint/StomachPoint/GenitaliaPoint/KneeHeight/FeetHeight
onready var default_height = abs((global_transform.orthonormalized().inverse() * feet_point.global_transform.origin).y)


func _physics_process(_delta):
    self.set_height(self.translation.y)


func set_height(value):
    scale.y = value / default_height
