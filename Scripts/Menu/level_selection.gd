extends Control

const LEVEL_BTN = preload("res://Scenes/Menu/lvl_button.tscn")

@export_dir var dir_path

@onready var grid = $MarginContainer/VBoxContainer/GridContainer

func _ready() -> void:
	get_levels(dir_path)

func get_levels(path) -> void:
	var dir = DirAccess.open("res://Scenes/Levels")
	
	var files_list = Array(dir.get_files())
	files_list.sort_custom(func	(a:String,b): return float(a.split("_",true,1)[1])<float(b.split("_",true,1)[1]))
	var min_width = files_list.map(func (s): return s.length()).max() * 15
	var min_size = Vector2(min_width,50)
	for file_name: String in files_list:
		print(file_name)
		create_level_btn('%s/%s' % [dir.get_current_dir(),file_name], file_name, min_size)

func create_level_btn(lvl_path:String, file_name:String, min_size:Vector2) -> void:
	var btn = LEVEL_BTN.instantiate()

	btn.text = "Level "+file_name.split("_",true,1)[1].trim_suffix(".tscn")
	btn.level_path = lvl_path
	btn.set_custom_minimum_size(min_size)
	grid.add_child(btn)
