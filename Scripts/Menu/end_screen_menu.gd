extends Control
	
func _on_next_button_down():
	print("GOTO NEXT STAGE")


func _on_level_selector_button_down():
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")
