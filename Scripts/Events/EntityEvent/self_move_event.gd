extends EntityEvent

@export var animation_speed = 4




var old_raycast_pos: Vector2
var grid_size: int


func apply(owner: Entity, context: LevelContext):
	if (owner != null and owner.contains_component("RayCast2D") and owner.contains_component("AnimatedSprite2D") and owner.contains_component("DirectionComponent")):
		#raycast = owner.get_component("RayCast2D") as RayCast2D
		#old_raycast_pos = raycast.position
		
		
		grid_size = LevelScene.instance.grid_size
		
		var line: Line2D = null
		
		
		if owner.contains_component("Line2D"):
			line = owner.get_component("Line2D") as Line2D
		
		var sprite: AnimatedSprite2D = owner.get_component("AnimatedSprite2D") as AnimatedSprite2D
		var direction_comp: DirectionComponent = owner.get_component("DirectionComponent") as DirectionComponent

		var should_move = false
		var move_dir = direction_comp.direction
		
		if (can_move_in_direction(move_dir, owner)):
			should_move = true
		elif (can_move_in_direction(move_dir * -1, owner)):
			should_move = true
			direction_comp.flip_direction()
		else:
			sprite.play("idle", 2)
			
		if should_move:
			sprite.play("walk", 2)
			var node = DFSNode.new(owner)
			var result = dfs(node, direction_comp.direction)
			var entities = result.map(func(node: DFSNode): return node.entity)			
			var tw = owner.create_tween()
			tw.set_parallel()

			for entity: Entity in entities:
				tw.tween_property(entity, "position", entity.position + direction_comp.direction * LevelScene.instance.grid_size, 1.0/animation_speed)
			tw.play()
			await tw.finished
					#
			for entity: Entity in entities:
				await entity.try_activate_trigger(context)
				
			
					#if (should_move):
			#
			#var tween = owner.create_tween()
			#tween.tween_property(owner, "position", owner.position + direction_comp.direction * grid_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
			#sprite.play("walk", 2)
			#await tween.finished
			#await owner.try_activate_trigger(context)				
		#else:
			#sprite.play("idle", 2)
#		#if (raycast.is_colliding()):
			#collider = raycast.get_collider()
			#raycast.target_position = raycast.position + (-1 * direction_comp.direction) * grid_size
			#raycast.force_raycast_update()
			#if (!raycast.is_colliding()):
				#should_move = true
				#direction_comp.flip_direction()
		#else:
			#should_move = true

			#var node = DFSNode.new(old_raycast_pos, owner)
			#var result = dfs(node, move_dir, context.gravity_direction)
			#var x = result.map(func(x): return x.area)
			#
			#var tw = owner.create_tween()
			#tw.set_parallel()
#
			#for area: Area2D in x:
				#tw.tween_property(area, "position", area.position + direction_comp.direction * LevelScene.instance.grid_size, 1.0/animation_speed)
			#tw.play()
			#await tw.finished
#
		#raycast.position = old_raycast_pos


		#print("START POSITION 1:", raycast.position)
		#raycast.position = 
		

#
#
		#if (line != null): 
			#line.clear_points()
			#line.add_point(Vector2(4, -4))
			#line.add_point(raycast.position + (direction_comp.direction * grid_size))


		
		#raycast.force_raycast_update()
		#if (raycast.is_colliding()):
			#collider = raycast.get_collider()
			#raycast.target_position = raycast.position + (-1 * direction_comp.direction) * grid_size
			#raycast.force_raycast_update()
			#if (!raycast.is_colliding()):
				#should_move = true
				#direction_comp.flip_direction()
		#else:
			#should_move = true
			#

		#if (should_move):
			#
			#var tween = owner.create_tween()
			#tween.tween_property(owner, "position", owner.position + direction_comp.direction * grid_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
			#sprite.play("walk", 2)
			#await tween.finished
			#await owner.try_activate_trigger(context)				
		#else:
			#sprite.play("idle", 2)


# For moving boxes

class DFSNode:
	var entity : Entity
	
	func _init(ent: Entity):
		self.entity = ent
		
func dfs(start_node: DFSNode, direction: Vector2):
	var to_move_stack = []
	var stack = [start_node]
	while stack.size() > 0:
		var node: DFSNode = stack.pop_back()
		var curr_raycast: RayCast2D = node.entity.get_component("RayCast2D") as RayCast2D
		curr_raycast.position = Vector2(4, -4)
		var target_positions = [curr_raycast.position + (direction * grid_size), curr_raycast.position + (LevelScene.instance.gravity * -1) * grid_size]
		for position: Vector2 in target_positions:
			curr_raycast.target_position = position
			curr_raycast.force_raycast_update()
			if (curr_raycast.is_colliding()):
				var collider = curr_raycast.get_collider()
				if (collider is Area2D and collider.is_in_group("Pushable")):
					var new_node = DFSNode.new(collider)
					stack.append(new_node)
					if !can_move_in_direction(direction, new_node.entity):
						break
				else:
					break
		if can_move_in_direction(direction, node.entity):
			to_move_stack.append(node)
			
	return to_move_stack

func can_move_in_direction(direction: Vector2, entity: Entity) -> bool:
	var curr_raycast = entity.get_component("RayCast2D") as RayCast2D
	var can_move = false
	curr_raycast.position = Vector2(4, -4)
	curr_raycast.target_position = curr_raycast.position + (direction * LevelScene.instance.grid_size) 
	curr_raycast.force_raycast_update()
	if curr_raycast.is_colliding():
		var collider = curr_raycast.get_collider()
		if collider is Entity and collider.is_in_group("Pushable"):
			return can_move_in_direction(direction, collider)
	else:
		can_move = true

	return can_move
