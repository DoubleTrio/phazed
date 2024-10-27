extends EntityEvent

@export var delay: float = 1.0;

func apply(level_scene: LevelScene, owner: Entity, context: LevelContext):
	print("This event always runs last")
	
	await level_scene.get_tree().create_timer(delay).timeout
	
