extends Spatial

func _ready():
    var osname = OS.get_name()
    print("OS name " + osname)
    print("VR interfaces: " + str(ARVRServer.get_interfaces()))
    if osname == "Android":
        var oq_success: bool = preload("res://vr-intergration/QuestConfig.gd").new().config(get_viewport())
        if not oq_success:
            # try other android VR headset runtimes
            pass
