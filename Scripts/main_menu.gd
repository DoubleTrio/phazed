extends Control


## Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/VBoxContainer/MenuOptions/Start.grab_focus();
	
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_start_button_down():
	get_tree().change_scene_to_file("res://Scenes/Levels/level1.tscn")
	#change_scene_to_file


func _on_options_button_down():
	print("Options Button")
	#get_tree().current_scene.add_child()

func _on_quit_button_down():
	print("Quit Button")
	get_tree().quit()
	
