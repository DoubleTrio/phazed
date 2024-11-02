extends Node

class_name TriggerComponent

@onready var pq = DS.PriorityQ.new([])
@export var trigger_scripts: Array[EntityEvent] = []

signal on_trigger()

func _ready() -> void:
	_insert_into_priority()

func _insert_into_priority():
	for priority_event: EntityEvent in trigger_scripts:
		pq.insert(priority_event.priority, priority_event)

func trigger(collider: Entity, owner: Entity, context: LevelContext):
	collider.last_collided = null
	on_trigger.emit()
	await get_tree().process_frame
	for script: EntityEvent in pq.get_queue():	
		await script.apply(owner, context)
