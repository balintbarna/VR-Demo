extends Node

func _ready():
    load_vr_interfaces()
    load_starting_scene()
    load_goldbox_scene()
    queue_free()


func load_goldbox_scene():
    SceneLoader.start_loading(SceneLibrary.get_gold_box_scene())


func load_starting_scene():
    if not OK == get_tree().change_scene_to(SceneLibrary.get_loading_room_scene()):
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
