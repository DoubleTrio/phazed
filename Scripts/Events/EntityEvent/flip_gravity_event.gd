extends EntityEvent
	
var event = preload("res://Scripts/Events/EntityEvent/global_fall_event.gd")

func apply(owner: Entity, context: LevelContext):
	LevelScene.instance.flip_gravity()
	var fall_event = event.new()
	await fall_event.apply(owner, context)
