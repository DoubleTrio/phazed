extends EntityEvent

func apply(owner: Entity, context: LevelContext):
	if (owner.contains_component("IDComponent")):
		LevelScene.instance.remove_entity(owner)
		var id_component: IDComponent = owner.get_component("IDComponent") as IDComponent
		
		var blocks = LevelScene.instance.blocks.duplicate(false)
		for block: Area2D in blocks:
			if block is LockBlock:
				if block.color_code.id == id_component.id:
					LevelScene.instance.remove_block(block)
