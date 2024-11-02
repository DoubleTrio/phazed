extends EntityEvent

@export var animation_speed = 16




var raycast: RayCast2D
var old_raycast_pos: Vector2
var grid_size: int


func apply(owner: Entity, context: LevelContext):
	if (owner != null and owner.contains_component("RayCast2D") and owner.contains_component("AnimatedSprite2D") and owner.contains_component("DirectionComponent")):
		raycast = owner.get_component("RayCast2D") as RayCast2D
		old_raycast_pos = raycast.position
		grid_size = LevelScene.instance.grid_size
		
		var line: Line2D = null
		
		
		if owner.contains_component("Line2D"):
			line = owner.get_component("Line2D") as Line2D
		
		var sprite: AnimatedSprite2D = owner.get_component("AnimatedSprite2D") as AnimatedSprite2D
		var direction_comp: DirectionComponent = owner.get_component("DirectionComponent") as DirectionComponent




		var should_move = false
		var collider = null
		var move_dir = direction_comp.direction
		
		
	
	
		
		#print("PLAYER POS: ", owner.global_position)
		#print(move_dir)

#
		#if (can_move_in_direction(move_dir)):
#
			#var node = DFSNode.new(old_raycast_pos, owner)
			#var result = dfs(node, move_dir, context.gravity_direction)
			#var x = result.map(func(x): return x.area)
			#print(x)
			#
			##var tw = owner.new()
#
			#var tw = owner.create_tween()
			#tw.set_parallel()
#
			#for area: Area2D in x:
				#tw.tween_property(area, "position", area.position + direction_comp.direction *  level_scene.grid_size, 1.0/animation_speed)
			#tw.play()
			#await tw.finished
#
		#raycast.position = old_raycast_pos


		#print("START POSITION 1:", raycast.position)
		#raycast.position = 
		

#
		raycast.position = Vector2(4, -4)
		raycast.target_position = raycast.position + (direction_comp.direction * grid_size) 

		if (line != null): 
			line.clear_points()
			line.add_point(Vector2(4, -4))
			line.add_point(raycast.position + (direction_comp.direction * grid_size))
		#print(raycast.position, "START")
		#print(raycast.target_position, "TARGET")
		#print("TARGET POSITION:", raycast.target_position)
		#print("TARGET POSITION 1:", raycast.target_position)

		raycast.force_raycast_update()
		if (raycast.is_colliding()):
			collider = raycast.get_collider()
			raycast.target_position = raycast.position + (-1 * direction_comp.direction) * grid_size
			raycast.force_raycast_update()
			if (!raycast.is_colliding()):
				should_move = true
				direction_comp.flip_direction()
		else:
			should_move = true
			

		if (should_move):
			
			var tween = owner.create_tween()
			tween.tween_property(owner, "position", owner.position + direction_comp.direction * grid_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
			sprite.play("walk", 2)
			await tween.finished
			owner.try_activate_trigger(context)
					
				
		else:
			sprite.play("idle", 2)


# For moving boxes

class DFSNode:
	var location : Vector2
	var area : Area2D
	
	func _init(location: Vector2, area: Area2D):
		self.location = location
		self.area = area
		
func dfs(start_node: DFSNode, direction: Vector2, gravity: Vector2):
	var to_move_stack = []
	
	var stack = [start_node]
	while stack.size() > 0:
		var current = stack.pop_back()
		#print("Visited:", current.location)
		raycast.position = current.location
		var target_positions = [current.location + (gravity * -1) * grid_size, current.location + (direction * grid_size)]
		to_move_stack.append(current)
		for position: Vector2 in target_positions:
			raycast.target_position = position
			raycast.force_raycast_update()
			
			
			print(raycast.position, " TO ", raycast.target_position)
			if (raycast.is_colliding()):
				var collider = raycast.get_collider()
				print("Collider: ", collider)
				if (collider is Area2D and collider.is_in_group("Pushable")):
					var node = DFSNode.new(position, collider)
					stack.append(node)
				else:
					pass
					#print(collider)
					#to_move_stack.append(current)
	return to_move_stack

func can_move_in_direction(direction: Vector2) -> bool:
	var can_move = false
	var offset = old_raycast_pos

	while true:
		raycast.position = offset
		raycast.target_position = offset + (direction * 8)
		print(raycast.position, raycast.target_position)

		# Trigger the raycast to check for collisions
		raycast.force_raycast_update()
		
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			
			if collider is Area2D and collider.is_in_group("Pushable"):
				# Move the raycast forward by 16 pixels in the given direction
				offset += direction * 16
				continue
			else:
		
				break
		else:
			can_move = true
			break

	# Reset raycast position to its initial state
	raycast.position = old_raycast_pos
	return can_move
