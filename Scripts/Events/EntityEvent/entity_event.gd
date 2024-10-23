extends Resource

class_name EntityEvent

@export var priority: float = 0.0

signal event_finished()

func apply(level_scene: LevelScene, owner: Entity, context: LevelContext):
	print("Base method called!")