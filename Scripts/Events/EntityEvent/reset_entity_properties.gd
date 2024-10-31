extends EntityEvent

func apply(owner: Entity, context: LevelContext):
	owner.last_collided = null
