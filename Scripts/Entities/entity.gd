extends Area2D

class_name Entity

@onready var active_effects: ActiveEffect = ActiveEffect.new()

@export var on_action_scripts: Array[EntityEvent] = []

@export var before_map_turn_start_scripts: Array[EntityEvent] = []
@export var on_map_turn_start_scripts: Array[EntityEvent] = []
@export var on_map_turn_end_scripts: Array[EntityEvent] = []

signal finished_action()
signal finished_on_turn_end()
signal finished_on_map_turn_end()

signal enter_detect_area(area: DetectAreaComponent)

@onready var _components_dict = {} 


func _ready():
	for component in get_children():
		_components_dict[component.name]  = component
	for priority_event: EntityEvent in on_map_turn_start_scripts:
		active_effects.on_map_turn_start_queue.insert(priority_event.priority, priority_event)
	for priority_event: EntityEvent in on_map_turn_end_scripts:
		active_effects.on_map_turn_end_queue.insert(priority_event.priority, priority_event)
	for priority_event: EntityEvent in on_action_scripts:
		active_effects.on_action_queue.insert(priority_event.priority, priority_event)
	
	
#var is_invincible = false :
	#set(value):
		#is_invincible = value
		#for child in get_children():
			#if not child is CollisionShape2D and not child is CollisionPolygon2D: continue
			#child.set_deferred("disabled", is_invincible)

func contains_component(component: String) -> bool:
	return _components_dict.has(component)

func get_component(component: String):
	return _components_dict[component]

func before_action(level_scene: LevelScene):
	print("before_action")
	print("TODO: implement")
	
func action(level_scene: LevelScene):
	var context: LevelContext = LevelContext.new()
	for script: EntityEvent in active_effects.on_action_queue.get_queue():	
		await script.apply(level_scene, self, context)
	finished_action.emit()
	
func on_turn_end(level_scene: LevelScene):
	var context: LevelContext = LevelContext.new()
	for script: EntityEvent in active_effects.on_turn_end.get_queue():	
		await script.apply(level_scene, self, context)
	finished_on_turn_end.emit()

func on_map_turn_end(level_scene: LevelScene):
	var context: LevelContext = LevelContext.new()
	for script: EntityEvent in active_effects.on_map_turn_end_queue.get_queue():	
		await script.apply(level_scene, self, context)
	finished_on_map_turn_end.emit()
