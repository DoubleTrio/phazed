extends Control

func _ready():
	$MarginContainer/VBoxContainer/MenuOptions/Start.grab_focus();
	
func _on_start_button_down():
	get_tree().change_scene_to_file("res://Scenes/Levels/level1.tscn")


func _on_options_button_down():
	print("Options Button")

func _on_quit_button_down():
	print("Quit Button")
	get_tree().quit()
