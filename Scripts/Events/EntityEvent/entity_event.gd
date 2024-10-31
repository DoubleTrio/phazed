extends Resource

class_name EntityEvent

@export var priority: float = 0.0

func apply(owner: Entity, context: LevelContext):
	print("Base method called!")
