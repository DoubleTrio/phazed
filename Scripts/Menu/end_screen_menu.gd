extends Control

class_name EndScreenMenu

var next_lvl_file_path
@onready var teleport_info = $VBoxContainer/TeleportInfo
@onready var next_button = $VBoxContainer/HBoxContainer/MarginContainer2/Next

func _ready() -> void:
	var file_path = get_tree().current_scene.scene_file_path
	var regex = RegEx.new()
	regex.compile("^res://Scenes/Levels/level_(\\d+)\\.tscn$")
	var curr_lvl_num = int(regex.search(file_path).get_string(1))
	regex.compile("(?<=^res://Scenes/Levels/level_)\\d+(?=\\.tscn$)")
	self.next_lvl_file_path = regex.sub(file_path,str(curr_lvl_num+1))
	if !FileAccess.file_exists(self.next_lvl_file_path):
		self.next_lvl_file_path = null
		next_button.disabled = true
		next_button.text = "No more levels!"

func _on_next_button_down():
	LevelScene.instance = null
	GameManager.selected_level = self.next_lvl_file_path
	get_tree().change_scene_to_file.bind(self.next_lvl_file_path).call_deferred()

func _on_level_selector_button_down():
	get_tree().change_scene_to_file("res://Scenes/Menu/level_selection.tscn")

func update_count(count: int):
	teleport_info.text = "Teleport Used: " + str(count)
