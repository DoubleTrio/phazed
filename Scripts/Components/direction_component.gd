extends Node

class_name DirectionComponent

signal direction_changed(direction: Vector2)

var direction: Vector2 = Vector2.RIGHT :
	set(value):
		if value == direction: return
		direction = value
		direction_changed.emit(direction)

func flip_direction() -> void:
	direction = direction * -1
	
func set_direction(dir: Vector2) -> void:
	direction = dir
	
