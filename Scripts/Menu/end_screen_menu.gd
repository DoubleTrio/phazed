extends Control

class_name EndScreenMenu

@onready var teleport_info = $VBoxContainer/TeleportInfo

func _on_next_button_down():
	print("GOTO NEXT STAGE")

func _on_level_selector_button_down():
	get_tree().change_scene_to_file("res://Scenes/Menu/level_selection.tscn")

func update_count(count: int):
	teleport_info.text = "Teleport Used: " + str(count)
