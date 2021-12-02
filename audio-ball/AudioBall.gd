tool
extends RigidBody


export var sphere_color: Color setget set_sphere_color, get_sphere_color
export var audio_stream: AudioStream setget set_audio_stream, get_audio_stream
var grab_handler: RigidBodyGrabHandler = RigidBodyGrabHandler.new()
onready var mesh_node = $CollisionShape/MeshInstance as MeshInstance
# warning-ignore:UNSAFE_CAST
onready var mesh = mesh_node.mesh as SphereMesh
# warning-ignore:UNSAFE_CAST
onready var audio_player = mesh_node.get_node("MeshInstance/AudioStreamPlayer3D") as AudioStreamPlayer3D


func _ready():
    update_sphere_color()
    update_audio_stream()
    if not Engine.editor_hint:
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
    if not Engine.editor_hint:
        grab_handler.process(delta)


func set_sphere_color(new_color: Color):
    sphere_color = new_color
    update_sphere_color()


func get_sphere_color():
    return sphere_color


func update_sphere_color():
    if mesh_node:
        mesh_node.get_active_material(0).albedo_color = sphere_color


func set_audio_stream(new_stream: AudioStream):
    audio_stream = new_stream
    update_audio_stream()


func get_audio_stream():
    return audio_stream


func update_audio_stream():
    if audio_player:
        audio_player.stream = audio_stream
