extends EntityEvent

@export var animation_speed = 16

func apply(level_scene: LevelScene, owner: Entity, context: LevelContext):
	if (owner != null and owner.contains_component("RayCast2D") and owner.contains_component("AnimatedSprite2D") and owner.contains_component("DirectionComponent")):
		var raycast = owner.get_component("RayCast2D") as RayCast2D
		var sprite: AnimatedSprite2D = owner.get_component("AnimatedSprite2D") as AnimatedSprite2D
		var direction_comp: DirectionComponent = owner.get_component("DirectionComponent") as DirectionComponent

		raycast.target_position = Helpers.map_str_to_vec(direction_comp.direction) * level_scene.grid_size
		raycast.force_raycast_update()
		if !raycast.is_colliding():
			pass
		else:
		
			# TODO - Check for direction flips when gravity flips
			if direction_comp.direction == "left":
				sprite.flip_h = false
			else: 
				sprite.flip_h = true
			direction_comp.flip_direction()
		var tween = owner.create_tween()
		tween.tween_property(owner, "position", owner.position + Helpers.map_str_to_vec(direction_comp.direction) *  level_scene.grid_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		sprite.play("walk", 2)
		await tween.finished
