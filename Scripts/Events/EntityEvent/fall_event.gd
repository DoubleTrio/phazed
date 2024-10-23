extends EntityEvent

@export var fall_speed: float = 1.0;


func apply(level_scene: LevelScene, owner: Entity, context: LevelContext):
	print("TODO: Fall then calculate all the triggers while we are falling")
	var gravity: Vector2 = context.gravity_direction
	if (owner != null and owner.contains_component("RayCast2D")):
		var raycast = owner.get_component("RayCast2D") as RayCast2D
