extends Node

func _ready():
    load_vr_interfaces()
    load_starting_scene()
    queue_free()


func load_starting_scene():
    var loading_room_scene: PackedScene = load("res://loading-room/LoadingRoom.tscn")
    if not OK == get_tree().change_scene_to(loading_room_scene):
        push_error("COULD NOT LOAD STARTING SCENE")


func load_vr_interfaces():
    var osname = OS.get_name()
    print("OS name " + osname)
    print("VR interfaces: " + str(ARVRServer.get_interfaces()))
    if osname == "Android":
        load_android_vr_interfaces()


func load_android_vr_interfaces():
    var oq_success: bool = QuestConfig.new().config(get_viewport())
    if not oq_success:
        push_error("Failed to register VR interfaces for Android")
