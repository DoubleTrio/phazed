extends EntityEvent

@export var fall_speed: float = 1.5;

func apply(owner: Entity, context: LevelContext):

	var gravity: Vector2 = LevelScene.instance.gravity
	var grid_size: int = LevelScene.instance.grid_size
	var sprite: AnimatedSprite2D
	
	if (owner != null and owner.contains_component("RayCast2D")):

		var raycast = owner.get_component("RayCast2D") as RayCast2D

		
		if (owner.contains_component("AnimatedSprite2D")):
			sprite = owner.get_component("AnimatedSprite2D") as AnimatedSprite2D
		
		var max_check = 64
		var tile_check = 1
		#
		## TODO: Check if the player hits any triggers while falling
		while (tile_check < 64):
			var end_position = gravity * grid_size * tile_check
			raycast.target_position = end_position
			raycast.force_raycast_update()
			if raycast.is_colliding():
				break
			tile_check += 1	
		if (tile_check > 1):
			#
			var total_tiles_fall = tile_check - 1
			#await level_scene.get_tree().create_timer(0.1).timeout
			var tween = owner.create_tween()	
			tween.tween_property(owner, "position", owner.position + gravity * grid_size * total_tiles_fall, 1.0/fall_speed).set_trans(Tween.TRANS_CUBIC)
			if (sprite != null):
				sprite.play("fall", 2)
			await tween.finished
			if (sprite != null):
				sprite.play("walk", 2)
