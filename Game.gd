extends Spatial

func _ready():
    var osname = OS.get_name()
    print("OS name " + osname)
    print("VR interfaces: " + str(ARVRServer.get_interfaces()))
    if osname == "Android":
        var oq_success = load("res://vr-intergration/QuestConfig.gd").new().config(get_viewport())
