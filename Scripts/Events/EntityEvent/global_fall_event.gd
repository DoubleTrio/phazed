extends EntityEvent

@export var fall_speed: float = 16
	
func apply(owner: Entity, context: LevelContext):
	await GameManager.wait(0.1)
	var gravity: Vector2 = LevelScene.instance.gravity
	var columns = {}

	var max_iterations: int = 0
	
	
	# Get all the entities that are able to fall and place them inside bins
	for entity: Entity in LevelScene.instance.entities:
		if (entity.contains_component("RayCast2D")):
			var tiles_to_file: int = 0
			var raycast: RayCast2D = entity.get_component("RayCast2D")
			var tile_num = entity.position.x / 16
			
			
			if (!columns.has(tile_num)):
				columns[tile_num] = []
			columns[tile_num].append(entity)
			max_iterations = max(max_iterations, len(columns[tile_num]))
			

	
	var sort_method = get_sort_method(LevelScene.instance.gravity)
	
	var keys = columns.keys()
	for key in keys:
		var entity_group: Array = columns[key]
		entity_group.sort_custom(sort_method)


	
	while (max_iterations > 0): 
		# Gather the list of entities to check for falling 
		var fall_check_entity_group: Array[Entity] = []
		for key in keys:
			
			var entity_group: Array = columns[key]
			var entity: Entity = entity_group.pop_back()
			if (entity != null):
				fall_check_entity_group.append(entity)
		await wait_all_finished_falling(fall_check_entity_group, context)
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
	
func wait_all_finished_falling(fall_check_entity_group, context):
	var count: int = 0
	var n: int = len(fall_check_entity_group)
	while count <= n:
		count = 0
		#var useless_tween = true
		var tw = LevelScene.instance.create_tween()
		tw.set_trans(Tween.TRANS_LINEAR)
		tw.set_parallel()
		tw.pause()
		for entity: Entity in fall_check_entity_group:
			
			
						
			var raycast: RayCast2D = entity.get_component("RayCast2D")
			raycast.position = Vector2(4, -4)
			var end_position = raycast.position + LevelScene.instance.gravity * LevelScene.instance.grid_size
			raycast.target_position = end_position
			raycast.force_raycast_update()

			if !raycast.is_colliding():
				#useless_tween = false
				tw.tween_property(entity, "position", entity.position + LevelScene.instance.gravity * LevelScene.instance.grid_size, 1.0/fall_speed)

			
			
			
				# Refector this later
				if entity is Box:
					tw.tween_callback(func():
						end_position = raycast.position + LevelScene.instance.gravity * LevelScene.instance.grid_size + (LevelScene.instance.gravity * 10)
						raycast.target_position = end_position
						raycast.force_raycast_update()
						if raycast.is_colliding():
							GameManager.play_sound("box.mp3")
					)
				
				var sprite
				if (entity.contains_component("AnimatedSprite2D")):
					sprite = entity.get_component("AnimatedSprite2D") as AnimatedSprite2D
		
					sprite.play("fall", 2)
					
					#useless_tween = false
					tw.tween_callback(func(): sprite.play("walk", 2))
			else:
				count += 1
				

						
				
		if count >= n:
			break
		
		#if useless_tween:
			#tw.stop()
		#else:
		tw.play()
		await tw.finished
		
				#GameManager.play_sound("woop.mp3")
		#
		for entity: Entity in fall_check_entity_group:
			await entity.try_activate_trigger(context)
