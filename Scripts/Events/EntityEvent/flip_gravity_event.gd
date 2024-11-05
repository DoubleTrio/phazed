extends EntityEvent
	
var event = preload("res://Scripts/Events/EntityEvent/global_fall_event.gd")

func apply(owner: Entity, context: LevelContext):
	#await LevelScene.instance.get_tree().create_timer(0.1).timeout
	#LevelScene.instance.gravity = Vector2(LevelScene.instance.gravity.y, -LevelScene.instance.gravity.x)

	LevelScene.instance.flip_gravity()
	
	var fall_event = event.new()
	await fall_event.apply(owner, context)
