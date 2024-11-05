
extends Node2D

class_name LevelScene

static var instance: LevelScene = null

var entities: Array[Entity] = [] as Array[Entity]
var blocks: Array[Area2D] = [] as Array[Area2D]


@onready var ent = $Entities
@onready var bl = $Blocks

@onready var teleport_manager: TeleportManager = $TeleportManager as TeleportManager
@onready var stats_hud: StatsHud = $"../UI/StatsHud" as StatsHud

@onready var active_effects: ActiveEffect = ActiveEffect.new()

@onready var tilemap_layer: TileMapLayer = $TileMapLayer as TileMapLayer

@export var game_stats: GameStats

@export var on_before_action_scripts: Array[EntityEvent] = []
@export var on_action_scripts: Array[EntityEvent] = []
@export var on_after_action_scripts: Array[EntityEvent] = []
@export var on_map_turn_start_scripts: Array[EntityEvent] = []
@export var on_map_turn_end_scripts: Array[EntityEvent] = []

@onready var grid_size = tilemap_layer.tile_set.tile_size.x

var times_teleported = 0
var gravity: Vector2 = Vector2.DOWN :
	set(value):
		if value == gravity: return
		gravity = value
		LevelEvents.on_gravity_changed.emit(value)


#LevelEvents.on_gravity_changed.connect(_gravity_change)

signal before_actions_finished()
signal actions_finished()
signal after_actions_finished()

signal start_map_turn_finished()
signal end_map_turn_finished()

var timer = Timer.new()



func _init():
	instance = self if instance == null else instance
	
func _ready() -> void:


	_insert_into_priority()
	LevelEvents.on_teleport.connect(_on_teleport)
	add_child(timer)
	timer.set_autostart(true)
	timer.set_wait_time(0.3)
	timer.connect("timeout", tick)
	timer.start()
	for children: Entity in ent.get_children():
		entities.append(children)

	for children: Area2D in bl.get_children():
		blocks.append(children)
	#print(bl)

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
		
func _on_teleport():
	times_teleported += 1
	game_stats.total_times_teleported += 1
	stats_hud.set_teleporter_label("Times Teleported: " + str(times_teleported))

func set_gravity(direction: Vector2):
	gravity = direction
	
func flip_gravity():
	gravity = gravity * -1
	
func tick():
	timer.paused = true
	var context: LevelContext = LevelContext.new()
	
	await wait_all_map_starts(context)
	#print("All map starts okay")
	await wait_all_before_actions(context)
	#print("All before action okay")
	await wait_all_actions(context)
	#print("All actions")
	await wait_all_after_actions(context)
	#print("All after actions")
	await wait_all_map_ends(context)
	timer.paused = false



func wait_all_before_actions(context: LevelContext):
	var sigs_map = entities.map(
		func(x: Entity): return x.finished_before_action
	)

	var sigs: Array[Signal] = []
	sigs.assign(sigs_map)
	
	for entity: Entity in entities:
		entity.before_action(self, context)
	await Promise.all(Promise.from_many(sigs)).wait()
	
func wait_all_actions(context: LevelContext):
	var sigs_map = entities.map(
		func(x: Entity): return x.finished_action
	)
	var sigs: Array[Signal] = []
	sigs.assign(sigs_map)
	
	for entity: Entity in entities:
		entity.action(self, context)
	await Promise.all(Promise.from_many(sigs)).wait()

func wait_all_after_actions(context: LevelContext):
	var sigs_map = entities.map(
		func(x: Entity): return x.finished_after_action
	)
	var sigs: Array[Signal] = []
	sigs.assign(sigs_map)
	
	for entity: Entity in entities:
		entity.after_action(self, context)
	await Promise.all(Promise.from_many(sigs)).wait()


func wait_all_map_starts(context: LevelContext):
	for script: EntityEvent in active_effects.on_map_turn_start_queue.get_queue():	
		await script.apply(null, context)
	var sigs_map = entities.map(
		func(x: Entity): return x.finished_map_turn_start
	)

	var sigs: Array[Signal] = []
	sigs.assign(sigs_map)
	
	for entity: Entity in entities:
		entity.map_turn_start(self, context)
	
	await Promise.all(Promise.from_many(sigs)).wait()


func wait_all_map_ends(context: LevelContext):

	for script: EntityEvent in active_effects.on_map_turn_end_queue.get_queue():	
		#print(script.resource_path)
		await script.apply(null, context)
	var sigs_map = entities.map(
		func(x: Entity): return x.finished_map_turn_end
	)

	var sigs: Array[Signal] = []
	sigs.assign(sigs_map)
	
	for entity: Entity in entities:
		entity.map_turn_end(self, context)
	
	await Promise.all(Promise.from_many(sigs)).wait()
	
func remove_entity(entity: Entity):
	entities.erase(entity)
	entity.queue_free()
	
func remove_block(block: Area2D):
	blocks.erase(block)
	block.queue_free()
	
