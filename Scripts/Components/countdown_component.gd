#extends Node
#
#class_name CountdownComponent
#
#signal on_countdown(count: int)
#
#@export var count = 1
#func _ready():
	#entity.area_entered.connect(_on_entity_entered)
	#entity.area_exited.connect(_on_entity_exited)
#
#func _on_entity_entered(entity: Area2D):
	#if not entity is Entity: return
	#enter_entity.emit(entity)
	#entity.enter_detect_area.emit(self)
#
#func _on_entity_exited(entity: Area2D):
	#if not entity is Entity: return
	#exit_entity.emit(entity)
