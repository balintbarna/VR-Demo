extends Node


func get_loading_room_scene() -> PackedScene:
    return preload("res://worlds/loading-room/LoadingRoom.tscn")


func get_gold_box_scene() -> ResourceInteractiveLoader:
    return ResourceLoader.load_interactive("res://worlds/golden-box/GoldenBox.tscn")


func get_portal_room_scene() -> ResourceInteractiveLoader:
    return ResourceLoader.load_interactive("res://worlds/portal-room/PortalRoom.tscn")
