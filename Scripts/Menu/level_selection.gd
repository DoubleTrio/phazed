extends Control

const LEVEL_BTN = preload("res://Scenes/Menu/lvl_button.tscn")

@export_dir var dir_path

@onready var grid = $MarginContainer/VBoxContainer/GridContainer

func _ready() -> void:
	get_levels(dir_path)

func get_levels(path) -> void:
	var dir = DirAccess.open("res://Scenes/Levels")
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	print(file_name)
	
	while file_name != "":
		print(file_name)
		create_level_btn('%s/%s' % [dir.get_current_dir(),file_name], file_name)
		file_name = dir.get_next()
	dir.list_dir_end()


func create_level_btn(lvl_path:String, lvl_name:String) -> void:
	var btn = LEVEL_BTN.instantiate()
	btn.text = lvl_name.trim_suffix('.tscn')
	btn.level_path = lvl_path
	grid.add_child(btn)
