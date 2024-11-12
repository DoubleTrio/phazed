extends Area2D

class_name Entity

@onready var active_effects: ActiveEffect = ActiveEffect.new()

@export var on_before_action_scripts: Array[EntityEvent] = []
@export var on_action_scripts: Array[EntityEvent] = []
@export var on_after_action_scripts: Array[EntityEvent] = []
@export var on_map_turn_start_scripts: Array[EntityEvent] = []
@export var on_map_turn_end_scripts: Array[EntityEvent] = []

signal finished_before_action()
signal finished_action()
signal finished_after_action()
signal finished_map_turn_start()
signal finished_map_turn_end()

signal enter_detect_area(detect_area: DetectAreaComponent)

signal exit_detect_area(detect_area: DetectAreaComponent)

@onready var _components_dict = {} 

@onready var DetectAreasDict = {} 

#var last_collided = null
func try_activate_triggers(context: LevelContext):
	#if has_recently_collided():
		#var area: DetectAreaComponent = self.last_collided
	var pq: DS.PriorityQ = DS.PriorityQ.new([])
	
	for key: DetectAreaComponent in DetectAreasDict.keys():
	
		if (key.entity.contains_component("TriggerComponent")):
			var trigger_comp: TriggerComponent = key.entity.get_component("TriggerComponent")
			pq.insert(trigger_comp.trigger_priority, key.entity)
	
	context.collider = self
	for entity: Entity in pq.get_queue():
		#await script.apply(self, level_context)
		var trigger_comp: TriggerComponent = entity.get_component("TriggerComponent")
		await trigger_comp.trigger(entity, context)
	context.collider = null

#func triggereD_c
func _ready():
	_init_components_dict()
	_insert_into_priority()
	enter_detect_area.connect(_enter_detect_area)
	exit_detect_area.connect(_exit_detect_area)


func _enter_detect_area(detect_area: DetectAreaComponent):
	DetectAreasDict[detect_area] = Time.get_ticks_msec()
	
func _exit_detect_area(detect_area: DetectAreaComponent):
	DetectAreasDict.erase(detect_area)
	
func _init_components_dict():
	for component in get_children():
		_components_dict[component.name] = component
		
func _insert_into_priority():
	for priority_event: EntityEvent in on_before_action_scripts:
		active_effects.on_before_action_queue.insert(priority_event.priority, priority_event)
	for priority_event: EntityEvent in on_action_scripts:
		active_effects.on_action_queue.insert(priority_event.priority, priority_event)
	for priority_event: EntityEvent in on_after_action_scripts:
		active_effects.on_after_action_queue.insert(priority_event.priority, priority_event)
	for priority_event: EntityEvent in on_map_turn_start_scripts:
		active_effects.on_map_turn_start_queue.insert(priority_event.priority, priority_event)	
	for priority_event: EntityEvent in on_map_turn_end_scripts:
		active_effects.on_map_turn_end_queue.insert(priority_event.priority, priority_event)

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

func before_action(level_scene: LevelScene, level_context: LevelContext):
	await GameManager.wait_next_frame()
	var pq = active_effects.on_before_action_queue.merge_with(level_scene.active_effects.on_before_action_queue)
	for script: EntityEvent in pq.get_queue():
		await script.apply(self, level_context)

	finished_before_action.emit()

	
func action(level_scene: LevelScene, level_context: LevelContext):

	await GameManager.wait_next_frame()
	var pq = active_effects.on_action_queue.merge_with(level_scene.active_effects.on_action_queue)
	for script: EntityEvent in pq.get_queue():
		await script.apply(self, level_context)
	finished_action.emit()
	
func after_action(level_scene: LevelScene, level_context: LevelContext):
	await GameManager.wait_next_frame()
	var pq = active_effects.on_after_action_end.merge_with(level_scene.active_effects.on_after_action_end)
	for script: EntityEvent in pq.get_queue():
		await script.apply(self, level_context)
	finished_after_action.emit()

func map_turn_start(level_scene: LevelScene, level_context: LevelContext):
	await GameManager.wait_next_frame()
	for script: EntityEvent in active_effects.on_map_turn_start_queue.get_queue():
		await script.apply(self, level_context)
	finished_map_turn_start.emit()

func map_turn_end(level_scene: LevelScene, level_context: LevelContext):
	await GameManager.wait_next_frame()
	for script: EntityEvent in active_effects.on_map_turn_end_queue.get_queue():
		await script.apply(self, level_context)
	finished_map_turn_end.emit()
