extends Area2D

class_name DetectAreaComponent

signal enter_entity(entity: Entity)
signal exit_entity(entity: Entity)

func _ready():
	area_entered.connect(_on_entity_entered)
	area_exited.connect(_on_entity_exited)

func _on_entity_entered(entity: Area2D):
	if not entity is Entity: return
	enter_entity.emit(entity)
	entity.enter_detect_area.emit(self)

func _on_entity_exited(entity: Area2D):
	if not entity is Entity: return
	exit_entity.emit(entity)
