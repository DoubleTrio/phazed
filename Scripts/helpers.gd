#extends Node
#
#var str_to_vec = {
	#"right": Vector2.RIGHT,
	#"left": Vector2.LEFT,
	#"up": Vector2.RIGHT,
	#"down": Vector2.DOWN
#}
#
#var vec_to_str = {
	#Vector2.RIGHT: "right",
	#Vector2.LEFT: "left",
	#Vector2.UP: "up",
	#Vector2.DOWN: "down"
#}
#
#func map_str_to_vec(dir_string: String) -> Vector2:
	#return str_to_vec.get(dir_string)
#
#func map_vec_to_str(direction: Vector2) -> String:
	#return vec_to_str.get(direction)
#
#func get_flip_direction(dir_string: String) -> String:
	#var dir: Vector2 = map_str_to_vec(dir_string)
	#var flipped_dir = dir * -1
	#return map_vec_to_str(flipped_dir)
	#
	#
