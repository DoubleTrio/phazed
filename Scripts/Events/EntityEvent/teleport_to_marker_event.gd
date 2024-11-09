extends EntityEvent

func apply(owner: Entity, context: LevelContext):
	print("HERE")
	if (owner is MarkerTeleporter):
		owner = owner as MarkerTeleporter
		context.collider.global_position = owner.marker.global_position
