tool
extends RigidBody


export var sphere_color: Color setget set_sphere_color, get_sphere_color
export var audio_stream: AudioStream setget set_audio_stream, get_audio_stream
onready var mesh_node = $CollisionShape/MeshInstance as MeshInstance
# warning-ignore:UNSAFE_CAST
onready var audio_player = mesh_node.get_node("MeshInstance/AudioStreamPlayer3D") as AudioStreamPlayer3D


func _ready():
    update_sphere_color()
    update_audio_stream()


func set_sphere_color(new_color: Color):
    sphere_color = new_color
    update_sphere_color()


func get_sphere_color():
    return sphere_color


func update_sphere_color():
    if mesh_node:
        mesh_node.get_active_material(0).set_shader_param("albedo_color", sphere_color)


func set_audio_stream(new_stream: AudioStream):
    audio_stream = new_stream
    update_audio_stream()


func get_audio_stream():
    return audio_stream


func update_audio_stream():
    if audio_player:
        audio_player.stream = audio_stream
