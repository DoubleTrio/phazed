extends EntityEvent

@export var fall_speed: float = 6
	
func apply(level_scene: LevelScene, owner: Entity, context: LevelContext):
	level_scene.flip_gravity()
	
	var gravity: Vector2 = level_scene.gravity
		
	var count: int = 0
	
	var columns = {}

	var max_iterations: int = 0
	
	for entity: Entity in level_scene.entities:
		if (entity.contains_component("RayCast2D")):
			var tiles_to_file: int = 0	
			var raycast: RayCast2D = entity.get_component("RayCast2D")
			var tile_num = entity.position.x / 16
			
			
			if (!columns.has(tile_num)):
				columns[tile_num] = []
			columns[tile_num].append(entity)
			max_iterations = max(max_iterations, len(columns[tile_num]))
			

	
	var sort_method = get_sort_method(gravity)
	
	var keys = columns.keys()
	for key in keys:
		var entity_group: Array = columns[key]
		entity_group.sort_custom(sort_method)


	
	while (max_iterations > 0): 

		
		
		var tw = level_scene.create_tween()
		tw.set_trans(Tween.TRANS_SINE)
		#tw.set_ease(Tween.EASE_IN)
		tw.set_parallel()
#
			#for area: Area2D in x:
				#tw.tween_property(area, "position", area.position + direction_comp.direction *  level_scene.grid_size, 1.0/animation_speed)

		for key in keys:
			var entity_group: Array = columns[key]
			var entity = entity_group.pop_back()
			if (entity != null):
				
				var sprite: AnimatedSprite2D = null
				
				if (entity.contains_component("AnimatedSprite2D")):
	
					sprite = entity.get_component("AnimatedSprite2D") as AnimatedSprite2D
				
				var raycast: RayCast2D = entity.get_component("RayCast2D")
				var max_check = 64
				var tile_check = 1
				#
				## TODO: Check if the player hits any triggers while falling
				while (tile_check < 64):
					var end_position = gravity * level_scene.grid_size * tile_check
					raycast.target_position = end_position
					raycast.force_raycast_update()
					if raycast.is_colliding():
						break
					tile_check += 1	
				if (tile_check > 1):
					#
					var total_tiles_fall = tile_check - 1
					#await level_scene.get_tree().create_timer(0.1).timeout
					tw.tween_property(entity, "position", entity.position + gravity * level_scene.grid_size * total_tiles_fall, 1.0/fall_speed)
					if (sprite != null):
						sprite.play("fall", 2)
						tw.tween_callback(func(): sprite.play("idle", 2))
						
		tw.play()
		await tw.finished
		max_iterations -= 1

func get_sort_method(gravity: Vector2):
	match gravity:
		Vector2.DOWN:
			return func(a: Entity, b: Entity): return a.position.y < b.position.y
		Vector2.UP:  
			return func(a: Entity, b: Entity): return a.position.y > b.position.y
		Vector2.LEFT:
			return func(a: Entity, b: Entity): return a.position.x < b.position.x
		Vector2.RIGHT:
			return func(a: Entity, b: Entity): return a.position.x > b.position.x
	
