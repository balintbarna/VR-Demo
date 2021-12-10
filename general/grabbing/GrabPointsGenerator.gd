extends Spatial
class_name GrabPointsGenerator


export var sphere_radius: float


func _ready():
    for alpha in range(-180, 180, 60):
        for beta in range(-180, 180, 60):
            call_deferred("create_point", alpha, beta)
    queue_free()


func create_point(alpha, beta):
    var node = Spatial.new()
    get_parent().add_child(node)
    var vec = Vector3(0, 0, sphere_radius).rotated(Vector3.RIGHT, deg2rad(alpha)).rotated(Vector3.UP, deg2rad(beta))
    node.translation = vec
    node.look_at(global_transform.origin, Vector3.UP)
