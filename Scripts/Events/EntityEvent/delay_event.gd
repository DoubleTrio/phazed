extends EntityEvent

@export var delay: float = 1.0;

func apply(owner: Entity, context: LevelContext):
	print("This event always runs last")
	
	await GameManager.wait(delay)
	
