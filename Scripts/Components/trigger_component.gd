extends Node

class_name TriggerComponent

@onready var pq = DS.PriorityQ.new([])
@export var trigger_scripts: Array[EntityEvent] = []

# The maximum amount of times the event can be trigger on one map turn
@export var count: int = -1

signal on_trigger()

func _ready() -> void:
	_insert_into_priority()

func _insert_into_priority():
	for priority_event: EntityEvent in trigger_scripts:
		pq.insert(priority_event.priority, priority_event)

func trigger(owner: Entity, context: LevelContext):
	# TODO: add counter to level context
	on_trigger.emit()
	await GameManager.wait_next_frame()
	for script: EntityEvent in pq.get_queue():	
		await script.apply(owner, context)
