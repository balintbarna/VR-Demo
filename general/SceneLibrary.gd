extends Node


func get_loading_room_scene() -> PackedScene:
    return preload("res://loading-room/LoadingRoom.tscn")


func get_gold_box_scene() -> ResourceInteractiveLoader:
    return ResourceLoader.load_interactive("res://golden-box/GoldenBox.tscn")
