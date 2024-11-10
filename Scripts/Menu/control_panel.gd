extends Control

@onready var restart_button = $VBoxContainer/HBoxContainer/RestartButton
@onready var pause_button = $VBoxContainer/HBoxContainer/PauseButton
@onready var speed_up_button = $VBoxContainer/HBoxContainer/SpeedUpButton

func _on_speed_up_button_button_down():
	if !LevelScene.instance.paused:
		Engine.time_scale = 2.2
		

func _on_speed_up_button_button_up():
	if !LevelScene.instance.paused:
		Engine.time_scale = 1

func _on_pause_button_button_down():
	LevelScene.instance.paused = !LevelScene.instance.paused

func _on_restart_button_button_down():
	LevelScene.instance = null
	get_tree().change_scene_to_file(GameManager.selected_level)
