#extends EntityEvent
#
#@export var fall_speed: float = 1.5;
#
#func apply(owner: Entity, context: LevelContext):
#
	#var gravity: Vector2 = context.gravity_direction
	#var grid_size = LevelScene.instance.grid_size
	#var sprite: AnimatedSprite2D
	#
	#if (owner != null and owner.contains_component("RayCast2D")):
#
		#var raycast = owner.get_component("RayCast2D") as RayCast2D
#
		#
		#if (owner.contains_component("AnimatedSprite2D")):
			#sprite = owner.get_component("AnimatedSprite2D") as AnimatedSprite2D
		#
		#var max_check = 64
		#var tile_check = 1
		##
		### TODO: Check if the player hits any triggers while falling
		#while (tile_check < 64):
			#var end_position = gravity * grid_size * tile_check
			#raycast.target_position = end_position
			#raycast.force_raycast_update()
			#if raycast.is_colliding():
				#break
			#tile_check += 1	
		#if (tile_check > 1):
			##
			#var total_tiles_fall = tile_check - 1
			##await level_scene.get_tree().create_timer(0.1).timeout
			#var tween = owner.create_tween()	
			#tween.tween_property(owner, "position", owner.position + gravity * grid_size * total_tiles_fall, 1.0/fall_speed).set_trans(Tween.TRANS_SINE)
			#if (sprite != null):
				#sprite.play("fall", 2)
			#await tween.finished
			#if (sprite != null):
				#sprite.play("walk", 2)


extends EntityEvent

@export var fall_speed: float = 16
	
func apply(owner: Entity, context: LevelContext):
	#print("GALL")
	await LevelScene.instance.get_tree().create_timer(0.1).timeout
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

#
			#for area: Area2D in x:
				#tw.tween_property(area, "position", area.position + direction_comp.direction *  level_scene.grid_size, 1.0/animation_speed)

		# Gather the list of entities to check for falling 
		var fall_check_entity_group: Array[Entity] = []
		for key in keys:
			
			var entity_group: Array = columns[key]
			var entity: Entity = entity_group.pop_back()
			if (entity != null):
				fall_check_entity_group.append(entity)
		await wait_all_finished_falling(fall_check_entity_group, context)
		#for entity: Entity in fall_check_entity_group:
			#await entity.try_activate_trigger(context)
		# Boolean to check everything has finished falling
		#var finished_falling = []
		#finished_falling.resize(len(fall_check_entity_group))
		#finished_falling.fill(false)
		#var all_true = .all(x => x == true)
		
		

			
		#finished_falling.all(func(x): return x)
		

		#print(finished_falling.all(func(x): return x))
		
		
	
		#while ()
				
				#
				#var sprite: AnimatedSprite2D = null
				#
				#if (entity.contains_component("AnimatedSprite2D")):
					#sprite = entity.get_component("AnimatedSprite2D") as AnimatedSprite2D
									#if (sprite != null):
						#sprite.play("fall", 2)
						#tw.tween_callback(func(): sprite.play("idle", 2))
				#var raycast: RayCast2D = entity.get_component("RayCast2D")
				#var max_check = 64
				#var tile_check = 1
				##
				### TODO: Check if the player hits any triggers while falling
				#while (tile_check < 64):
					#var end_position = gravity * LevelScene.instance.grid_size * tile_check
					#raycast.target_position = end_position
					#raycast.force_raycast_update()
					#if raycast.is_colliding():
						#break
					#tile_check += 1	
				#if (tile_check > 1):
					##
					#var total_tiles_fall = tile_check - 1
					#tw.tween_property(entity, "position", entity.position + gravity * LevelScene.instance.grid_size * total_tiles_fall, 1.0/fall_speed)
					#if (sprite != null):
						#sprite.play("fall", 2)
						#tw.tween_callback(func(): sprite.play("idle", 2))
						#
		#tw.play()
		#await tw.finished
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
		var tw = LevelScene.instance.create_tween()
		tw.set_trans(Tween.TRANS_LINEAR)
		tw.set_parallel()		
		for entity: Entity in fall_check_entity_group:
			
			

						
			var raycast: RayCast2D = entity.get_component("RayCast2D")
			raycast.position = Vector2(4, -4)
			var end_position = raycast.position + LevelScene.instance.gravity * LevelScene.instance.grid_size
			raycast.target_position = end_position
			raycast.force_raycast_update()
			if !raycast.is_colliding():
				tw.tween_property(entity, "position", entity.position + LevelScene.instance.gravity * LevelScene.instance.grid_size, 1.0/fall_speed)
			else:
				count += 1
				
			var sprite
			
			if (entity.contains_component("AnimatedSprite2D")):
				sprite = entity.get_component("AnimatedSprite2D") as AnimatedSprite2D
	
				sprite.play("fall", 2)
				tw.tween_callback(func(): sprite.play("idle", 2))
						
				
		if count >= n:
			break
			
		tw.play()
		await tw.finished
		#
		for entity: Entity in fall_check_entity_group:
			await entity.try_activate_trigger(context)
