extends EntityEvent

func apply(owner: Entity, context: LevelContext):
	GameManager.wait(3)
	if (owner.contains_component("IDComponent") and context.collider is Character):
		LevelScene.instance.remove_entity(owner)
		var id_component: IDComponent = owner.get_component("IDComponent") as IDComponent
		var blocks = LevelScene.instance.blocks.duplicate(false)
		for block: Area2D in blocks:
			if block is LockBlock:
				if block.color_code.id == id_component.id:
					block.action()
