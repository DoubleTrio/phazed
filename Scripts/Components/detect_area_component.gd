extends Node

class_name DetectAreaComponent

@export var entity: Entity

@onready var EntityDictionary = {}

signal enter_entity(entity: Entity)
signal exit_entity(entity: Entity)

func _ready():
	entity.area_entered.connect(_on_entity_entered)
	entity.area_exited.connect(_on_entity_exited)

func _on_entity_entered(area: Area2D):
	if not area is Entity: return
	enter_entity.emit(area)
	EntityDictionary[area] = Time.get_ticks_msec()
	area.enter_detect_area.emit(self)

func _on_entity_exited(area: Area2D):
	if not area is Entity: return
	exit_entity.emit(entity)
	EntityDictionary.erase(area)
	
var latest_entity : Entity :
	get : 
		var ent = null
		var values: Array = EntityDictionary.values()
		if len(values) != 0:
			var m = EntityDictionary.values().max()
			ent = EntityDictionary.find_key(m)
		return ent
