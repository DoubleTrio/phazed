extends EntityEvent

func apply(owner: Entity, context: LevelContext):
	LevelScene.instance.remove_entity(owner)
	LevelScene.instance.timer.stop()
	LevelScene.instance.end_screen.visible = true
	#for entity: Entity in LevelScene.instance.entities:
		#if (entity.contains_component("AnimatedSprite2D")):
			#var sprite: AnimatedSprite2D = owner.get_component("AnimatedSprite2D") as AnimatedSprite2D
			#sprite.play("fall", 2)
		
