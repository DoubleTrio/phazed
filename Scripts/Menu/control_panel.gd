extends Control

@onready var restart_button = $VBoxContainer/HBoxContainer/RestartButton as TextureButton
@onready var pause_button = $VBoxContainer/HBoxContainer/PauseButton as TextureButton
@onready var speed_up_button = $VBoxContainer/HBoxContainer/SpeedUpButton as TextureButton

# TODO: Disable the button instead of checking if paused?
func _on_speed_up_button_button_down():
	if !LevelScene.instance.paused:
		LevelScene.instance.set_speed(LevelScene.Speed.FAST)
		
func _on_speed_up_button_button_up():
	if !LevelScene.instance.paused:
		LevelScene.instance.set_speed(LevelScene.Speed.NORMAL)
		
func _on_pause_button_button_down():
	LevelScene.instance.paused = !LevelScene.instance.paused

func _on_restart_button_button_down():
	LevelScene.instance = null
	get_tree().change_scene_to_file(GameManager.selected_level)
