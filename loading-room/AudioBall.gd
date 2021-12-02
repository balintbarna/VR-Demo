extends RigidBody


export var grab_handler: Resource = RigidBodyGrabHandler.new()
onready var mesh_node = $CollisionShape/MeshInstance as MeshInstance
onready var mesh = mesh_node.mesh as SphereMesh


func _ready():
    var grab_points = []
    for alpha in range(-180, 180, 60):
        for beta in range(-180, 180, 60):
            var node = Spatial.new()
            var radius = mesh.radius
            add_child(node)
            grab_points.append(node)
            var vec = Vector3(0, 0, radius).rotated(Vector3.RIGHT, deg2rad(alpha)).rotated(Vector3.UP, deg2rad(beta))
            node.translation = vec
            node.look_at(global_transform.origin, Vector3.UP)
    grab_handler.body = self
    grab_handler.grab_points = grab_points


func _physics_process(delta):
    grab_handler.process(delta)
