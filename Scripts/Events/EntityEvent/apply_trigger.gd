extends EntityEvent

func apply(owner: Entity, context: LevelContext):
	await owner.try_activate_trigger(context)
