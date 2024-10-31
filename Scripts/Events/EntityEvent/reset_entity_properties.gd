extends EntityEvent

func apply(level_scene: LevelScene, owner: Entity, context: LevelContext):
	owner.last_collided = null
