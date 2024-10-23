
extends Node2D

class_name LevelScene

var entities: Array[Entity] = [] as Array[Entity]
@onready var ent = $Entities
@onready var teleport_manager: TeleportManager = $TeleportManager as TeleportManager
@onready var stats_hud: StatsHud = $"../UI/StatsHud" as StatsHud

@onready var active_effects: ActiveEffect = ActiveEffect.new()


@export var game_stats: GameStats
@export var before_map_turn_start_scripts: Array[EntityEvent] = []
@export var on_turn_end_scripts: Array[EntityEvent] = []
@export var on_map_turn_start_scripts: Array[EntityEvent] = []
@export var on_map_turn_end_scripts: Array[EntityEvent] = []

var grid_size = 16

var times_teleported = 0

signal all_actions_finished()
signal end_turn_actions_finished()

var timer = Timer.new()

func _ready() -> void:
	LevelEvents.on_teleport.connect(_on_teleport)
	add_child(timer)
	timer.set_autostart(true)
	timer.set_wait_time(0.5)
	timer.connect("timeout", tick)
	timer.start()
	for children: Entity in ent.get_children():
		entities.append(children)
	for priority_event: EntityEvent in on_map_turn_start_scripts:
		active_effects.on_map_turn_start_queue.insert(priority_event.priority, priority_event)
		#
	for priority_event: EntityEvent in on_map_turn_end_scripts:
		active_effects.on_map_turn_end_queue.insert(priority_event.priority, priority_event)
	
func _on_teleport():
	times_teleported += 1
	game_stats.total_times_teleported += 1
	stats_hud.set_teleporter_label("Times Teleported: " + str(times_teleported))
	
func tick():
	timer.paused = true
	var context: LevelContext = LevelContext.new()
	await wait_all_actions(context)
	
	# TODO Wait all events
	
	
	for script: EntityEvent in active_effects.on_map_turn_end_queue.get_queue():	
		await script.apply(self, null, context)
	timer.paused = false

func wait_all_actions(context: LevelContext):
	var finished_action_count: int = 0
	for entity: Entity in entities:
		entity.action(self)
		entity.finished_action.connect(
			func(): 
				finished_action_count += 1
				if (finished_action_count == len(entities)):
					all_actions_finished.emit()
		)	
	await all_actions_finished
	
func wait_all_map_turn_end(context: LevelContext):
	var finished_action_count: int = 0
	for entity: Entity in entities:
		#entity.finished_on_map_turn_end(self)
		entity.finished_action.connect(
			func(): 
				finished_action_count += 1
				if (finished_action_count == len(entities)):
					end_turn_actions_finished.emit()
		)	
	await end_turn_actions_finished
	

func on_turn_end():
	pass
func on_entity_turn_end():
	pass
func on_map_turn_end():
	pass
