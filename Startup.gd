extends Node

func _ready():
    load_vr_interfaces()
    load_starting_scene()
    load_portal_room_scene()
    queue_free()


func load_portal_room_scene():
    SceneLoader.start_loading(SceneLibrary.get_portal_room_scene())


func load_starting_scene():
    if not OK == get_tree().change_scene_to(SceneLibrary.get_loading_room_scene()):
        push_error("COULD NOT LOAD STARTING SCENE")


func load_vr_interfaces():
    var osname = OS.get_name()
    print("OS name " + osname)
    print("VR interfaces: " + str(ARVRServer.get_interfaces()))
    if osname == "Android":
        load_android_vr_interfaces()
    else:
        load_openxr()


func load_openxr():
    var oxr_success: bool = OpenXrConfig.new().config(get_viewport())
    if not oxr_success:
        push_error("Failed to register VR interfaces for Desktop")


func load_android_vr_interfaces():
    var oq_success: bool = OculusMobileConfig.new().config(get_viewport())
    if not oq_success:
        push_error("Failed to register VR interfaces for Android")
