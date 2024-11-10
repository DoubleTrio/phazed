extends EntityEvent

func apply(owner: Entity, context: LevelContext):
	if context.collider is Character:
		LevelScene.instance.remove_entity(owner)
		LevelScene.instance.timer.stop()
		LevelScene.instance.end_screen.visible = true
		LevelScene.instance.level_complete.emit()
		
