extends Node2D

func _input(event):
	# Check if the left mouse button is pressed
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_global_mouse_position()
		print("Mouse Position (Global):", mouse_pos)
