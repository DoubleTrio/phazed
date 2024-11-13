extends Control

class_name EndScreenMenu

@onready var teleport_info = $VBoxContainer/TeleportInfo

func _on_next_button_down():
	var file_path = get_tree().current_scene.scene_file_path
	var regex = RegEx.new()
	regex.compile("^res://Scenes/Levels/level_(\\d+)\\.tscn$")
	var curr_lvl_num = int(regex.search(file_path).get_string(1))
	regex.compile("\\d+(?=\\.tscn)")
	var next_lvl_file_path = regex.sub(file_path,str(curr_lvl_num+1))
	print(next_lvl_file_path)
	LevelScene.instance = null
	get_tree().change_scene_to_file.bind(next_lvl_file_path).call_deferred()

func _on_level_selector_button_down():
	get_tree().change_scene_to_file("res://Scenes/Menu/level_selection.tscn")

func update_count(count: int):
	teleport_info.text = "Teleport Used: " + str(count)
