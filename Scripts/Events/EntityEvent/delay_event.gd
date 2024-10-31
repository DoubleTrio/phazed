extends EntityEvent

@export var delay: float = 1.0;

func apply(owner: Entity, context: LevelContext):
	print("This event always runs last")
	
	await LevelScene.instance.get_tree().create_timer(delay).timeout
	
