extends Node

class_name DirectionComponent

signal direction_changed()

var direction = "right" :
	set(value):
		if value == direction: return
		direction = value
		direction_changed.emit()

func flip_direction() -> void:
	direction = Helpers.get_flip_direction(direction)

func set_direction(dir: String) -> void:
	direction = dir
	
